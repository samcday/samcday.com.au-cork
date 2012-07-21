---
date: '2011-05-18 12:37:37'
layout: post
slug: facebook-open-graph-html5-validation-problems
status: publish
title: Facebook Open Graph HTML5 Validation Problems
wordpress_id: '179'
categories:
- Facebook Development
- Web Development
tags:
- facebook
- facebook like button
- html5
- open graph
- standards
---

I'm currently working on a site currently that uses a few [Facebook "Like" buttons](http://developers.facebook.com/docs/reference/plugins/like/) scattered around the place. As such the pages that can be "Liked" need a modest amount of [Open Graph metadata](http://developers.facebook.com/docs/opengraph/) embedded in them.

The fun part of this is that the [Open Graph specification](http://ogp.me/) states that OG metadata should be embedded on the page like so:

[html]
<meta property="og:title" content="The Rock" />
<meta property="og:type" content="movie" />
<meta property="og:url" content="http://www.imdb.com/title/tt0117500/" />
<meta property="og:image" content="http://ia.media-imdb.com/images/rock.jpg" />
[/html]

The stupid thing is this is actually invalid HTML5. The HTML5 spec states that meta tags must use the **name**/**content** attributes, and because OG is based off [RDFa](http://en.wikipedia.org/wiki/RDFa), an XHTML draft, OG mandates that its metadata uses the **property** attribute instead of the **name** attribute. After [Googling](http://www.google.com/search?q=meta+property+invalid&hl=en) [around](http://www.google.com/search?q=og:title+meta+property+invalid+markup&hl=en) a [bit](http://www.google.com/search?q=html5+open+graph+meta+property&hl=en) I came to the "conclusion" that the only way to get a page to validate with Open Graph tags was to switch to XHTML.

Screw that.

Instead I tried just changing the property attributes back to name and run it through the [Facebook URL Linter](http://developers.facebook.com/tools/lint) tool. Turns out, Facebook will grumble at you, but they will still parse OG data out of standard meta tags, and Like Buttons will use that metadata just fine.

So, in summary, if you're authoring a straight HTML5 (non-XHTML) site, you have a choice between pissing off W3C, or pissing off Facebook. It's your call.

I've put up two examples for reference, one uses [meta property (non-standard)](http://sambro.is-super-awesome.com/lolopengraph-openfailmorelikeit/doesntvalidate.html), the other uses [meta name (standard)](http://sambro.is-super-awesome.com/lolopengraph-openfailmorelikeit/doesvalidate.html).
