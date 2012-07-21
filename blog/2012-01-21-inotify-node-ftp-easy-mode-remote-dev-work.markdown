---
date: '2012-01-21 23:11:55'
layout: post
slug: inotify-node-ftp-easy-mode-remote-dev-work
status: publish
title: Inotify + Node + FTP = Easy-mode remote dev work
wordpress_id: '193'
categories:
- Javascript
- Node.js
- Programming
tags:
- coffeescript
- inotify
- php
---

**Pre-ramble**

Haven't updated my blog in a while, but I had a fun little win tonight that I thought I'd share with the lovely readers of this blog (you know I love all 3 of you).

I am currently working fulltime at Wotif.com in Brisbane, and I'm extremely fortunate to be immersed in the weird and wondrous world of Groovy/Grails for the majority of application development I'm involved in. To make things even more awesome-er we're currently working a on a project that uses CouchDB/ElasticSearch as our primary data provider. Life is bliss. Well, mostly.

**The Problem**

I still have work come in occasionally from a long-time client I respect enough to give some time to on the weekend. Unfortunately this work is in the form of PHP4 code most of the time. And no, the pain doesn't just end there, usually the work is on a fairly large production Joomla 1.0 site. Needless to say, the technical debt flows freely.

Anyway, this particular site is a real pain to work on, as it's not really in a state where it can be run up locally without a fair amount of pain and misery. I haven't done much work for this particular client in the last few months, and thus I didn't really have a proper LAMP stack running on my machine at home (nor do I really want to). A more recent project I'd done for this client last year was a Joomla 1.5 site, where I had the luxury of "doing it right" - I had set the project up to easily be run up locally using some bash scripts, [UnionFS](http://en.wikipedia.org/wiki/UnionFS), and a little bit of voodoo. But no such win was to be had for this Joomla 1.0 site.

The work I needed to perform on the Joomla 1.0 site was considerable enough that the prospect of firing up Filezilla and manually FTPing changes was unbearable. In the past I've used Eclipse with an obscure plugin called [ESFTP](http://sourceforge.net/projects/esftp/) to push my changes to the server as I develop. However this still has an obnoxious required manual step of clicking a button every time I want to push a file to the server.

I figured there had to be an easier way. Then I remembered seeing some cool inotify stuff in Node.js a while ago.

**The Solution**

I thought to myself: "Wouldn't it be cool if I had a little Node app running that monitored my project on the filesystem and FTP'd changes to the codebase as I made them?".

So I decided to cook something up. A couple of hours later I came up with this:

[https://gist.github.com/1652663](https://gist.github.com/1652663)

I didn't end up using the libinotify bindings for Node.js, as it was a little too low level for a quick prototype. The main pain point was the fact that inotify isn't actually recursive, so you actually have to put together your own code that recursively creates watch descriptors for the directory structure, glue in new watch descriptors as new directories get created, and delete old descriptors as directories disappear. I instead opted to use the awesome inotifywait tool (which comes from the inotify-tools package in Ubuntu) which handles all the un-fun parts of inotify and instead sends nice little status updates on stdout.

Oh, and I was getting bizzare issues with the [node-ftp](https://github.com/mscdex/node-ftp) library from NPM, so I just grabbed the latest from the git repo and threw it in with the script.

So now I just fire up this script with the FTP details and paths. It just sits there patiently and creates/deletes directories as needed, and pushes file changes/deletions as they occur.

Now this could definitely have easily been done using pretty much any language, but I think it's a pretty neat and elegant little CoffeeScript/Node solution :)

Speaking of Node/CoffeeScript, I've been working on a little project in all the spare time I can get. I'm excited to blog about some of the cool stuff I've found/done in that regard in the coming weeks!

That's all for now, internets.
