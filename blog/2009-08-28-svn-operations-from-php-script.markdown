---
date: '2009-08-28 10:52:16'
layout: post
slug: svn-operations-from-php-script
status: publish
title: SVN operations from PHP script
wordpress_id: '10'
---

So, being the OCD psycho that I am, I like to make things efficient. I don't like workarounds or compromises.

What I have is a project I've been working on for a while, it's a PHP site. I have it sitting in an SVN repository and it's basically just been me working on it. Currently I was just making changes then updating them via FTP on the server. It's a fairly complex site so now it's gotten to the point where there's plenty of pitfalls to doing this (breaking permissions, etc etc). Oh did I mention I was just pushing stuff directly to production site?

So I'm about to bring some contractors in to work on the site, I decided I obviously need a staging server. But that's not enough - I need it to update automatically! The complication? The SVN server and the staging server are two physically different servers. The traditional solution found from most Google searches is the post-commit hook executing a small binary to update a working copy elsewhere in the filesystem.

What I devised is a simple PHP script sitting on the dev server, when post-commit hook is called on SVN server it executes this script via cURL commandline.

The tricky part was getting the svn update php script to work. In the end I figured out a pretty decent solution. The trick was to set up sudo on the server and execute SVN commands via sudo in PHP.

I'm using Plesk, so when I created the dev server vhost a dev user was created. So what I did was edited /etc/sudoers and added the following:

apache ALL=(dev) NOPASSWD:/usr/bin/svn

What this does is allow apache (remember that PHP scripts execute under apache user and group) to execute svn under the dev user. The NOPASSWD is important, sudo only accepts input from interactive shell (there are some hacky ways of injecting cleartext but I found them to be somewhat hit and miss). NOPASSWD ensures that sudo does what we ask it to do, no questions asked. 

So from the PHP script I had something like the following:

	$sudoCommand = "/usr/bin/sudo -u dev ";
	$svnUpdateCommand = "{$sudoCommand}/usr/bin/svn update --username devserver --password blah --non-interactive 2>&1";
	$svnCleanupCommand = "{$sudoCommand}/usr/bin/svn cleanup 2>&1";

The rest is pretty self explanatory! Redirecting stderr to stdout, setting authentication details, blah blah blah. exec()'ing the command above does the trick.

Hope this helps someone!
