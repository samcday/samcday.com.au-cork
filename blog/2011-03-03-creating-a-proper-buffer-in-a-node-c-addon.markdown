---
date: '2011-03-03 09:14:53'
layout: post
slug: creating-a-proper-buffer-in-a-node-c-addon
status: publish
title: Creating a proper Buffer in a Node C++ Addon
wordpress_id: '171'
categories:
- Javascript
- Node.js
- Programming
- Web Development
tags:
- Buffer
- Node
- Node.js
- SlowBuffer
- SSJS
---

Despite the wordy title, it's actually a fairly simple problem, with a fairly simple solution.

Let's say you have some binary data you want to provide to Node Javascript. No problem, Node has [Buffers](http://nodejs.org/docs/v0.4.1/api/buffers.html) for that. Digging through the Node.js source code, you find [node_buffer.h](https://github.com/joyent/node/blob/master/src/node_buffer.h), which promises a utopia of an [ObjectWrap](https://github.com/joyent/node/blob/master/src/node_object_wrap.h) goodness; you can even memcpy your binary data directly to it using Buffer::Data(bufferObject). 

"Fantastic! I'll rock one of those buffers and simply return `bufferObject->handle_`!", I hear you exclaim. Not so fast stud.

If the client were to use this Buffer, they'd get a nasty surprise. It's not a Buffer. You see, Node.js has re-implemented Buffers since 0.2. The Buffer you're playing with from node_buffer.h is actually a _**SlowBuffer**_. As the name implies, it's working directly on the heap-allocated memory chunk, so alot of operations on it are quite inefficient. Worse still, the interface provided on SlowBuffer is actually different to the Node.js documentation. Allow me to explain.

The Buffer you're used to dealing with from Node.js user code actually originates from [buffer.js](https://github.com/joyent/node/blob/master/lib/buffer.js). These Buffers are actually just "views" on a proper SlowBuffer, so operations like slicing are literally as quick as allocating a new Buffer object that views the SlowBuffer at a different offset and max length.

So how do you create one of these badboys from C++ to pass directly back to JS calling code? Glad you asked. Like so:

[code lang="cpp"]
	// Some data we want to provide to Node.js userland code.
	// This can be binary of course.
	const char *data = "Hello world!";
	int length = strlen(data);
	
	// This is Buffer that actually makes heap-allocated raw binary available
	// to userland code.
	node::Buffer *slowBuffer = node::Buffer::New(length);
	
	// Buffer:Data gives us a yummy void* pointer to play with to our hearts
	// content.
	memcpy(node::Buffer::Data(slowBuffer), data, length);

	// Now we need to create the JS version of the Buffer I was telling you about.
	// To do that we need to actually pull it from the execution context.
	// First step is to get a handle to the global object.
	v8::Local<v8::Object> globalObj = v8::Context::GetCurrent()->Global();
	
	// Now we need to grab the Buffer constructor function.
	v8::Local<v8::Function> bufferConstructor = v8::Local<v8::Function>::Cast(globalObj->Get(v8::String::New("Buffer")));
	
	// Great. We can use this constructor function to allocate new Buffers.
	// Let's do that now. First we need to provide the correct arguments.
	// First argument is the JS object Handle for the SlowBuffer.
	// Second arg is the length of the SlowBuffer.
	// Third arg is the offset in the SlowBuffer we want the .. "Fast"Buffer to start at.
	v8::Handle<v8::Value> constructorArgs[3] = { slowBuffer->handle_, v8::Integer::New(length), v8::Integer::New(0) };
	
	// Now we have our constructor, and our constructor args. Let's create the 
	// damn Buffer already!
	v8::Local<v8::Object> actualBuffer = bufferConstructor->NewInstance(3, constructorArgs);
	
	// This Buffer can now be provided to the calling JS code as easy as this:
	return scope.Close(actualBuffer);
[/code]

And that's all folks!
