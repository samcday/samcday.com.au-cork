---
date: '2010-06-01 12:22:54'
layout: post
slug: gotcha-removing-border-in-ie
status: publish
title: 'Gotcha: Removing iframe border in IE.'
wordpress_id: '144'
categories:
- Programming
- Technology
- Web
- Web Development
tags:
- border
- frameborder
- gotcha
- ie6
- ie6 sucks
- iframe
---

Think I'm gonna start a little mini-series of blog posts with the little "gotchas" I run into during the course of an ordinary day at work. Some of the pitfalls I've run into lately have been ridiculous. Bloody IE!

Todays one is a fun one. Removing a frameborder on an iframe in Internet Explorer is case-sensitive, would you believe it!

That is to say:
[php htmlscript="true"]
<iframe frameborder="0" src="http://www.google.com.au/"></iframe>
[/php]
.. Probably won't work. Whereas:
[php htmlscript="true"]
<iframe frameBorder="0" src="http://www.google.com.au/"></iframe>
[/php]
Will!

This also extends to creating an iframe using DOM. You need to do this:
Think I'm gonna start a little mini-series of blog posts with the little "gotchas" I run into during the course of an ordinary day at work. Some of the pitfalls I've run into lately have been ridiculous. Bloody IE!

Todays one is a fun one. Removing a frameborder on an iframe in Internet Explorer is case-sensitive, would you believe it!

That is to say:
[php htmlscript="true"]
myIframeEl.setAttribute("frameborder", "0");
[/php]
Is not going to work in IE.
[php htmlscript="true"]
myIframeEl.setAttribute("frameBorder", "0");
[/php]
But this will.
