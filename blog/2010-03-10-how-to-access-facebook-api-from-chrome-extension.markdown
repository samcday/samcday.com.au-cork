---
date: '2010-03-10 12:58:20'
layout: post
slug: how-to-access-facebook-api-from-chrome-extension
status: publish
title: How to access Facebook API from Chrome Extension
wordpress_id: '79'
categories:
- Chrome Extension Development
- Facebook Development
- Javascript
- Technology
- Web
---

So following on from my previous post, I decided I wanted to try two new things at once: Facebook API and a foray into developing a Google Chrome extension. With the notification API that will (hopefully) twig on in other major browsers, I'm writing an extension that will display a desktop notification when a Facebook notification is received. All that will be required is for Chrome to be running.

Step 1 was to play around with Chrome extensions. I haven't worked with plugins/extensions in any other browser, but I have to say.... Google NAILED this. It's so intuitive and straightforward. So easy to debug, so much power. I love you Google.

Anyway. Step 2 was where things got interesting - connecting to Facebook via the [Javascript API](http://wiki.developers.facebook.com/index.php/JavaScript_Client_Library) and [Facebook Connect](http://wiki.developers.facebook.com/index.php/Facebook_Connect). This proved to be quite complex. Facebook Connect has this fascination with the whole [cross domain communication channel](http://wiki.developers.facebook.com/index.php/Cross_Domain_Communication_Channel) (XD for shortness) nonsense. Basically, this requirements essentially means to use the Javascript API you need to be hosting it on a standard web server to be able to add the xd_receiver.html file in a public-facing area where Facebook can see it.

After digging around the site for a while, I came across their fancy new [Open Source Javascript SDK](http://wiki.developers.facebook.com/index.php/JavaScript_SDK_(Open_Source)), I couldn't help but notice this didn't make a mention of the XD setup anywhere, so I assumed perhaps I might be able to work with this system better. As it happens, my suspicions were correct. The new JS library has some crazy voodoo magic set up so that an XD file isn't required, there's some kind of "XD proxy" running on the Facebook servers which will send login session data along the line to the JS library, using either [document.postMessage](https://developer.mozilla.org/en/DOM/window.postMessage) or some Flash workaround thingy (not really sure how that works, don't particularly care.)

I immediately tried to use it in a Chrome extension, but alas! There was a few issues. I came up with workarounds for both though.

**Issue #1** - the API does the following in the constructor:

`
 _domain: {
      api : window.location.protocol + '//api.facebook.com/',
      cdn : (window.location.protocol == 'https:'
              ? 'https://s-static.ak.fbcdn.net/'
              : 'http://static.ak.fbcdn.net/'),
      www : window.location.protocol + '//www.facebook.com/'
    },
`

Great! That would be fantastic if our chrome extension was running on http, but the protocol when running from options or background.html pages is "chrome-extension://". So when the API went to make with the server side communications, it was trying to remote to chrome-extension://api.facebook.com, which of course is not really gonna work.

My solution to this was to just fudge it by putting the following snippet in before using the FB lib anywhere:

`
FB._domain = {
      api : 'https://api.facebook.com/',
      cdn : 'https://s-static.ak.fbcdn.net/',
      www : 'https://www.facebook.com/'
};
`

With that change, the API won't have any more tantrums when trying to phone home. Easy!

**Issue #2** - Facebook Connect is still broken.

This one was the biggie. Essentially, even though the new API does some cool hocus pocus with XD, it's still referencing the "origin domain" in the request, this original domain is of course just going to be the extension URL, which is not terribly useful, as Facebook will freak out when it gets a request coming from an invalid URL. I tried fudging the origin to a valid domain (dodgy I know, I was getting desperate). Interestingly, Facebook was fine with this, but of course when the request came back to the browser and the XD proxy tries to postMessage() the session data back, the browser freaks out as it looks like an XSS attack.

There might be other ways around this drama, but I opted for what I feel to be a fairly elegant solution.

Essentially, I opted to "pretend" I'm something of a desktop application trying to authenticate with Facebook application (which is true in a sense, I suppose). This [Developer Wiki page](http://wiki.developers.facebook.com/index.php/Authorization_and_Authentication_for_Desktop_Applications) gave me some insight into how to authenticate my application with the FB user  the old-fashioned way.

The idea is this: popup the login/app-authenticate page manually with a special URL, setting the return URL to a random dummy Facebook page they have running for desktop app clients: http://www.facebook.com/connect/login_success.html. When the user visits the login page, once they have logged in and allowed the app access (or if they are already logged in and have already allowed the app), they are redirected to a page that has the session data in the querystring encoded in JSON. Login achieved.

So I set about doing this in my extension, simple enough to start with:

`
var win = window.open("http://www.facebook.com/login.php?api_key=&connect;_display=popup&v;=1.0&next;=http://www.facebook.com/connect/login_success.html&cancel;_url=http://www.facebook.com/connect/login_failure.html&fbconnect;=true&return;_session=true&session;_key_only=true", "fbconnect", "width=400,height=400");
`

Great! If I was a *real* desktop application and I was running a Webkit/IE/whatever browser instance as some kind of evil overlord, I could just detect when the browser redirects to login_sucess.html, grab the querystring, parse the session data out of it, and be on my merry way! I'm running in a browser though, so how about I just access the child window that I opened with window.open, access the location.search property and parse that? "NO", says the magical little pixies living inside the browser, "That would be against my strict Same Origin Policy (SOP, kinda like ... sop story, teehee)!!!".

Fair enough. There was an easy enough workaround though, I just embedded a [content script](http://code.google.com/chrome/extensions/content_scripts.html) via the Extension to sniff out the session data when it became available, and send it to the main extension. Like so:

Add the trigger for the content script to the extension manifest.json file:

`
  "content_scripts": [
    {
	"matches": ["http://www.facebook.com/connect/login_success.html*"],
	"js": ["prototype.js", "intercept_session.js"]
    }
  ],
`

I threw prototype in there just for convenience sake, as you'll see in the next step.

Then intercept_session.js looks like this:

`var params = window.location.search.toQueryParams();

if(!params.session) return;
var session = JSON.parse(params.session);

chrome.extension.sendRequest({message: "setSession", session: session}, function() {
  window.close();
});`

What this code does is parse the querystring (using Prototype), then check if the session data is present. If it is, parse the JSON into the session object and send it off to the extension [Background Page](http://code.google.com/chrome/extensions/background_pages.html) via the extension [message passing system](http://code.google.com/chrome/extensions/messaging.html) to be saved.

The background page simply has this:

`
var session = null;
if(localStorage.session)
{
  session = JSON.parse(localStorage.session);
}

chrome.extension.onRequest.addListener(
  function(request, sender, sendResponse) {
    if(!request.message)
      return;

    switch(request.message)
    {
      case "setSession":
      {
	localStorage.session = JSON.stringify(request.session);
	session = request.session;
	sendResponse();
	break;
      }
      case "getSession":
      {
	sendResponse(session);
	break;
      }
    }
  });
`

Again, pretty straightforward stuff. I'm using the groovy new [HTML5 local storage](http://dev.w3.org/html5/webstorage/) to remember the session data even if the browser is closed. The message handler simply listening for a session to be passed to it. When a session is provided, it will save it to local storage and a local variable. The getSession functionality is so other areas of your chrome extension can retrieve the session as needed (for example if you have a popup and want to query FB from there or something). You could obviously use this session anywhere as needed.

And that's that! From here you can make API calls to your hearts content. There's obviously some important things left out here, stale checking of the session when the background page loads up for example. Also, requesting [extended permissions](http://wiki.developers.facebook.com/index.php/Extended_permissions) is not covered here, but it's pretty much the same as how the login deal works anyway. You would just update the login_success.html intercept script to check if this was a response for extended permissions, and check the querystring to ensure the permissions were supplied.

I've cooked up a quick little demonstration of this stuffs. Click [here ](http://sambro.is-super-awesome.com/Example Facebook API Extension.crx)to install a demo extension that will add a button to the right of your address bar, which will show some clickable icons of 5 of your friends in a popup. You can also see the code for this extension [here](http://sambro.is-super-awesome.com/Example Facebook API Extension.zip).

Time for me to go finish this extension!
