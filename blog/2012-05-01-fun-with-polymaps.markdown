---
date: '2012-05-01 21:04:14'
layout: post
slug: fun-with-polymaps
status: publish
title: Fun with Polymaps
wordpress_id: '225'
categories:
- Javascript
- Programming
- Technology
- Web Development
tags:
- choropleth map
- geojson
- Javascript
- mapping
- polymaps
- svg
---

Recently I had a few ideas I wanted to try out in geographical data visualization. I've never really done any data vis stuff, other than a few charts here and there, so I had no clue where to even begin. 

At Wotif, I've been heavily involved in the [Reviews system](http://www.wotif.com/hotel/View?hotel=W1649&page=1&adults=0&child1Age=1&child2Age=1&child3Age=1&child4Age=1&child5Age=1&child6Age=1&child7Age=1&child8Age=1&child9Age=1&startDay=2012-05-01#reviews), which went live a couple of months ago. What I wanted to do was color a world map to signify the density of Reviews for hotels in each country. After some pathetic Google-fu, I ran into the [Geochart visualization from Google Chart Tools](https://developers.google.com/chart/interactive/docs/gallery/geochart). The Geochart visualization was a good start, but I quickly discovered just how limited it was when it comes to client-side interaction. I was sure there must be something more, but having never had much to do with mapping on the interwebz, I could not even begin to figure out the question I needed to ask, let alone the answer.

Thankfully, I discovered that what I was trying to display was a [Choropleth Map](http://en.wikipedia.org/wiki/Choropleth_map). Once I knew this, it didn't take long before I stumbled upon this [fantastic blog post](http://gis-techniques.blogspot.com.au/2011/05/choropleth-mapping-techniques-for-web20.html) from someone trying to do exactly the same thing as I. It was through this article that I had my eyes opened to a [whole](http://cloudmade.com) [world](http://cartographer.visualmotive.com/) [of](http://openstreetmap.org/) [amazing](http://leaflet.cloudmade.com/) [mapping](http://modestmaps.com/) [tools](http://mapbox.com/) [and](http://openlayers.org/) [libraries](http://polymaps.org/). The one that struck me as the most interesting was none other than [Polymaps](http://polymaps.org/), primarily because of the way it leveraged SVG for some pretty sexy looking ["slippy" maps](http://wiki.openstreetmap.org/wiki/Slippy_Map).

Even once I'd gotten my foothold in this wealth of information, I was still pretty lost. Answering my initial question lead to a myriad more. What is [GeoJSON](http://www.geojson.org/)? How do [tiles](http://wiki.openstreetmap.org/wiki/Tiles) work? Where does a [Tile Cache](http://tilecache.org/) come into play in all this? Wading through the mass amounts of information was pretty daunting.

In the end I focussed back in on what I was trying to do. I wanted a simplistic world map that I could mutate and accept user input on. Poring over the Polymaps examples, I determined that GeoJSON would help me render an world map with country outlines. A bit more Googling and I found a fantastic Github repo - [johan/world.geo.json](https://github.com/johan/world.geo.json), with all countries in a GeoJSON file.

Armed with this GeoJSON file, I was easily able to fumble about and mash my face against the keyboard until I got the desired result, a nice Choropleth map that users could mouseover to see more information! I bundled this up in a nice little dashboard with some other statistics I cooked up. I've since shown it to a few people at Wotif and they seem to like it.

The initial experiment only whetted my appetite though, and I'm finding myself quite engrossed in the world of amateur cartography. I've since started cooking up some interesting real-time displays using Polymaps, overlaying SVG drawing onto the map and doing some fun stuff with it, like smooth panning/zooming between points and extents. I will blog more about some of the cool stuff I've come up with.

Bye internets!
