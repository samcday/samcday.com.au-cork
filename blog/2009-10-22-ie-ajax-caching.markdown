---
date: '2009-10-22 11:20:56'
layout: post
slug: ie-ajax-caching
status: publish
title: IE + AJAX == Caching???
wordpress_id: '17'
categories:
- Technology
- Web
---

So I'm finishing up a fairly straightforward web booking system for a firm I'm working for. Everything is just about done so of course the final (and much dreaded) task is to make sure everything looks pretty, and works! Numerous CSS hacks and several hot showers rocking back and forth with blood-shot eyes later .... I now have the site looking fairly consistent in all the major browsers.

The system also has some AJAX mixed in for good measure, with standard HTML fallbacks if the client-side code falls over (you know, 'cos I have little faith in myself ...). Internet explorer was giving me some bizarre results with these AJAX methods, so I went digging.

As it happens, it was the same ol' story, Internet Explorer aggressively caches practically anything it can. This isn't necessarily a bad thing, but as usual Firefox, Chrome, Safari etc don't exhibit the behaviour.

I have actually run into this issue in several other projects, the way I generally solved it was to just generate some "entropy" in the request URL querystring to ensure IE fetched the data properly each time. This time I Google'd and looked a little deeper.

As it happens, caching HTTP GET requests is actually considered the "right" thing to do, so Internet Explorer actually chose this time to stick to standards and shove it in the face of everyone else. Somewhat ironic, considering they seem to go out of their way to do the complete **opposite** most of the time.

The solution is to just make POST requests to your endpoint, it seems to eliminate any caching IE thinks it should be doing. This has been posted all over the net already of course, but I felt to reiterate it because it's such an obvious solution to a very frequent and frustrating issue!
