---
date: '2011-06-27 16:44:44'
layout: post
slug: listening-for-end-of-response-with-nodeexpress-js
status: publish
title: Listening for end of response with Node/Express.JS
wordpress_id: '186'
categories:
- Javascript
- Node.js
- Programming
- Technology
tags:
- coffeescript
- express
- Node
- nodejs
- redis
---

I'm currently working with CoffeeScript, Node, Express, and Redis to deliver on a quick'n'easy contract I've been put in charge of. This is the first time I've used any of these technologies in a proper commercial deliverables type project, and I have to say, it's been an absolute delight.

An issue I ran into was I wanted to reduce the boilerplate on handling requests, so I wrote a quick route middleware in Express to create a client connection to Redis, assigning the connection to the request object for easy use . I also wanted to be clever and have this same middleware clean up after itself when the request ended. That is, I wanted the middleware to QUIT the Redis connection when the response had been sent.

Consulting the Express/Connect/Node docs yielded no clues as to how to do this, the closest hint I found was from the Node docs indicating that a http.ServerResponse is a WritableStream. I noticed WritableStreams had a "close" event that is supposed to be called when the Stream is no longer writable. I assumed that if you call **.end()** on a response then it should trigger this event, so my initial middleware looked like this:

[code]
setupRedisClient = (req, res, next) =>
	req.redisClient = require("redis").createClient()

	cleanup = =>
		console.log "it worked!"
		req.redisClient.quit()

	res.on "close", cleanup
	res.on "error", cleanup

	next()
[/code]

I tried using this middleware in a route, and was sad to see that the event was not being triggered.

As a last resort I started digging through the Node source, and lo and behold! I found what I was looking for in [lib/http.js](https://github.com/joyent/node/blob/master/lib/http.js#L714). Turns out when you **.end()** your http response, it will emit a "finish" event.

Now my Redis middleware looks like so:

[code]
setupRedisClient = (req, res, next) =>
	req.redisClient = require("redis").createClient()

	cleanup = =>
		req.redisClient.quit()

	res.on "finish", cleanup
	res.on "error", cleanup

	next()
[/code]

Incoming routes that need a Redis connection simply add this middleware, and hey presto! They can use req.redisClient to their hearts content. Once a response is sent back to the client, or an error occurs with the request, the Redis connection will be cleaned up automagically! Hurrah!
