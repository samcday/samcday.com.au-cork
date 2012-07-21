---
date: '2010-05-28 16:31:26'
layout: post
slug: facebook-access-tokens-from-canvas-apps
status: publish
title: Facebook Access Tokens from Canvas Apps
wordpress_id: '135'
categories:
- Facebook Development
- Programming
- Technology
- Web Development
tags:
- access token
- graph api
- oauth
---

> **UPDATE 26/07/10: ** looks like the Facebook Platform team is addressing this issue presently. There's a new migration option available to send session data in the request. When I used this parameter it seems that all old session related fb_sig parameters were no longer being sent, so I'd probably avoid using this. Instead refactor your applications to use the new [OAuth support for Canvas apps](http://developers.facebook.com/docs/authentication/canvas), which is also available to enable in the App Settings Migration tab.



There's an [open bug](http://bugs.developers.facebook.com/show_bug.cgi?id=9879) over at the Facebook bug tracker detailing an issue people are having with Canvas pages and the new Graph API. Right now, Facebook canvas applications are posting a session_key to the canvas callback URL. The new OAuth system of course uses the access token system, rather than the session_keys from the old Rest API.

There's a bit of info hiding in the documentation [upgrade guide](http://developers.facebook.com/docs/guides/upgrade) that outlines how to "exchange" a session key for an access token. All you need to do is POST some info to an endpoint and it'll spit back a valid access token.

Like so:
[php]
	$ch = curl_init("https://graph.facebook.com/oauth/exchange_sessions");
	curl_setopt($ch, CURLOPT_POST, true);
	curl_setopt($ch, CURLOPT_POSTFIELDS, array(
		"type" => "client_cred",
		"client_id" => "<your canvas application id>",
		"client_secret" => "<your canvas application secret>",
		"sessions" => $_REQUEST["fb_sig_session_key"]
	));

	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	$result = json_decode(curl_exec($ch));
	$accessToken = $result[0]->access_token;
[/php]

So what's going on here? You're POSTing a request to the Facebook OAuth implementation to exchange your session key for an access token. You provide your application id and secret (important: this needs to be id and secret for the canvas application the request originated from of course) and the session ID of the user. Send this off and a JSON response will come back with the access token. Also, if needed, there's another property passed back - "expires", which will let you know when this access token will die.

Okay, so now you have an access token for use with the new API. Now what?

There's a little bit of fudging required to use this with the PHP SDK. The setSession() method of the PHP SDK doesn't just take an access token, it expects all the other crap that is usually contained in the cookie it saves. The idea behind my solution is that you shouldn't need to modify any base classes. The code below will con the Facebook library into accepting your newly acquired access token:

[php]
	$session = array(
		"uid" => "",
		"session_key" => "",
		"secret" => "",
		"access_token" => $accessToken
	);
	ksort($session);
	$sessionStr = "";
	foreach($session as $sessionKey => $sessionValue) $sessionStr .= implode("=", array($sessionKey, $sessionValue));
	$session["sig"] = md5($sessionStr."<your app secret>");
	$facebook->setSession($session, false);
[/php]

What this code is doing is constructing a fake session object. Since the only thing the SDK actually looks at in this session data is the access_token, we just fill the other entries with an empty str. Once this is done, we just calculate a signature for the data, as per the [Facebook Wiki documentation](http://wiki.developers.facebook.com/index.php/Verifying_The_Signature). Again, we're only doing this because the setSession() method demands it.

Once this is done, you can go ahead and make api calls! Now wasn't that easy? :)

Also, as a little footnote, you should know that you don't actually have to fudge the session, you can just pass the access token you get into each api call, like so:

[php]
$facebook->api(array("method" => "stream.get", "access_token" => $accessToken));
[/php]

... But this is a bit cumbersome. Also, with the fake session, you can just remove my code later when Facebook starts sending access token in the initial POST data.

You can see this solution in action at this [Facebook page](http://www.facebook.com/apps/application.php?id=125960984094309&v=app_125960984094309). Just click grant access, then click Go.

Hope this helps someone!
