---
date: '2010-10-28 21:51:53'
layout: post
slug: gotcha-flash-based-upload-widgets-stopping-mid-upload
status: publish
title: 'Gotcha: Flash-based Upload widgets stopping mid upload'
wordpress_id: '161'
tags:
- upload problems
- yahoo ui
- yui
- yui uploader
---

Posting in my blog for the first time in months. I just had to put this one up somewhere because it has been causing me to rip my hair out for the past 2 freakin' hours!

I have a page accepting uploads (using Yahoo UI uploader) for large files. I had it working a while ago but then I modified the whole design quite alot recently. All of a sudden when testing the uploader would randomly stop uploading after a couple of seconds, with absolutely no warning. I went so far as to trace the Flash logging output coming from the YAHOO uploader.swf to see what was going on - sure enough, it was spamming to the console the current upload status, and then randomly stopping out of the blue. No error messages. No warnings. No nothin'.

So it turns out I had the browse button sitting in a div with some text, and when the upload button was clicked, I was calling jQuery("#browseContainer").slideUp() to hide the text and browse button. Boom, that's what was causing it. No shit.

Turns out jQuery's slideUp() will put display:none on the animated element when it's done ... slideUpping it. Awesome story though - Flash plugins decide they shouldn't be running anymore when their parent element has display:block on it. No shit. This might be documented somewhere, but I'll be damned if it's common knowledge. Maybe I'm a total retard ...

Hope this helps someone.
