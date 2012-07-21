---
date: '2010-08-30 13:44:30'
layout: post
slug: facebook-platform-updates-w00t
status: publish
title: Facebook Platform updates - w00t!
wordpress_id: '155'
categories:
- CSS
- Facebook Development
- Javascript
- Programming
- Technology
- Web
- Web Development
tags:
- facebook platform
- fbjs
- fbml
---

According to [this blog post](http://developers.facebook.com/blog/post/402) over at developers.facebook.com, some exciting changes are coming to the Facebook Platform.

I'm a little slow on the uptake here, the blog update I'm referring to is now 10 days old. I haven't been in the Facebook dev world of late, so I hope you'll forgive me for regurgitating old news.

The big update for me is in the 4th paragraph:



> 
We are also moving toward IFrames instead of FBML for both canvas applications and Page tabs. As a part of this process, we will be standardizing on a small set of core FBML tags that will work with both applications on Facebook and external Web pages via our JavaScript SDK, effectively eliminating the technical difference between developing an application on and off Facebook.com.




This is excellent! I have actually been holding my breath for something like this for a while now. The restriction of FBML only content for tabs has been extremely restrictive, here are a handful of reasons why:



	
  * **Very strict HTML parsing** - because the Platform was rendering tabs inline previously, it of course had to be VERY careful in how it handled offsite data, to protect users from all manner of scams/attacks. Now full flexibility is available because your iFrame is yours to control.

	
  * **Insanely strict JS parsing** - same as first point, application tabs could only leverage basic Javascript and the unwieldy, poorly documented FBJS (Facebook Javascript). Now, you're free to access manipulate your IFrame document/window objects, DOM manipulate, include third party JS libs, etc, all to your hearts content.

	
  * **Embedded media was a pain** - Granted, the tab FBML *did* allow you to embed Flash and AIR apps etc, but there were countless threads on the forum outlining issues they were having interacting with the host page, etc.


  * **Tab activation policies** - There were some extremely frustrating rules with the way tabs were allowed to be "activated". No JS/FBJS was allowed to execute until the user had interacted with the tab in some manner, such as focusing a form element or clicking somewhere. This made it very cumbersome to implement any meaningful interactions with the user; alot of obnoxious boilerplate code had to be written for various ways in which you may actually start doing anything meaningful from JS, like AJAX requests.


  * **... and lots more** Everything from CSS parsing to the occasional time where the tab would just sit in an endless loading display when clicked. When I was writing a tab page I remember bashing my head against the wall trying to get some content to sit nicely in a cross browser fashion... it would have been easy under normal circumstances, but the Platform tab flavour was refusing to accept the *display: inline IE hack in the CSS. Joy.



This is going to really open up some great possibilities for interactive, rich web applications. I really cannot wait for this feature to be rolled out.

This news does come with some disappointment however; the sixth paragraph on the developers blog states the following:




> Finally, due to low usage rates, we will remove application tabs from user profiles in the next couple months. Application tabs will continue to be supported on Facebook Pages.



There are plenty of great use cases to have application tabs on a user profile page. My personal Facebook profile has a tab that displays my latest last.fm scrobbles, my latest blog posts, etc. Personally, I believe that if the adoption rate for user profile tabs is low, the Facebook team should be coming up with ways to increase user acceptance of this feature, rather than removing it all together. Besides, the functionality in Facebook Page tabs is pretty much identical to the user profile equivalents... Why not support both?

There's other goodies in the developer blog update too, such as [cleaning up the REST API](http://developers.facebook.com/roadmap/deprecations) considerably.

All in all, exciting changes coming to the Facebook platform in the coming months!
