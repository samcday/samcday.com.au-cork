---
date: '2010-03-08 15:52:12'
layout: post
slug: shiny-desktop-notifications-from-google-chrome
status: publish
title: Shiny Desktop Notifications from Google Chrome
wordpress_id: '50'
categories:
- Javascript
- Technology
- Web
---

So I was dicking around in Google Calendar the other day, updating settings and trolling for any cool new Labs stuff to enable... Anyway, I made some changes and clicked submit. I was provided with the ol' yellow InfoBar that asked me for permission to allow something to ... blah blah blah. I was a on a Google site and I have pretty much entrusted my soul to Google already - so I didn't bother reading it before clicking Allow.

Imagine my surprise when a sexy little desktop notification popped up in the bottom right of my screen! Intrigued, I did a bit of Googling, there's a [couple](http://lifehacker.com/5350238/google-chrome-to-feature-desktop-notifications) of [news](http://techcrunch.com/2009/09/01/chrome-is-gaining-desktop-notifications/) posts about it, but nothing substantial... other than the [design doc](http://dev.chromium.org/developers/design-documents/desktop-notifications/api-specification) hosted on dev.chromium.org.

It's currently only available in the [developer channel](http://dev.chromium.org/getting-involved/dev-channel) of Google Chrome. If you're running the dev channel, then check out the example below:








Your browser does not support Desktop Notifications.










You need to grant permission to this site to display notifications. [Grant Now](javascript:requestPermission();)







Permission for this website to display notifications has been explicitly denied. Don't you love me? ;( [Recheck Permission](javascript:checkPermission();)







Permission requested. Check your info bar (yellow bar at the top of the browser viewport).







There is currently a notification active. [Cancel](javascript:cancelNotification();)







There is currently  notifications active.







A notification will appear in  seconds. Go ahead and minimize or change tabs now.







Desktop Notifications active. [Show Notification](javascript:showNotification();) | [Show Many Notifications](javascript:showManyNotifications();) | [Show Timed Notification](javascript:showTimedNotification();)







For those interested, that code that powers this little example can be found [here](http://sambro.is-super-awesome.com/wp-content/uploads/notifications.js).

Very cool stuff. There are so many places this would come in handy. Super Facebook notifications, anyone?
