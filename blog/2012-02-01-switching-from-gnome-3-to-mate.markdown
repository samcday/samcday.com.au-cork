---
date: '2012-02-01 18:57:56'
layout: post
slug: switching-from-gnome-3-to-mate
status: publish
title: Switching from Gnome 3 to MATE
wordpress_id: '217'
tags:
- Gnome
- MATE
- Ubuntu
---

So my Linux distro of choice for quite a while has been Ubuntu. Unfortunately it seems that lately Canonical has embarked on a mission to destroy the desktop experience with religious fervor. I have no qualms in saying that I think Unity is the worst thing to ever happen to Ubuntu - it's a complete unmitigated disaster. How it managed to become the default overnight without rioting in the streets is beyond me - but I digress.

Of course there are other alternatives in the Desktop Linux scene; offerings such as [XFCE](http://www.xfce.org/), [LXDE](http://lxde.org/) and [KDE](http://www.kde.org/) all have their place. I personally don't have the time to familiarize myself with yet another desktop environment, especially given that my goal is to be running a Mac at work and at home. I had grown quite fond of GNOME 2 in previous releases of Ubuntu, so my next logical step was to use [GNOME 3](http://www.gnome.org/).

The problem with GNOME 3 is that of immaturity. It's still pretty rough around the edges (it crashes at least a couple of times a day for me under regular use), has very poor display driver support, and doesn't quite have the community momentum for themes and plugins like its predecessor had.

I've been using GNOME 3 for the past few months (at work and home) with the hopes that my gripes with it would be addressed shortly but unfortunately I'm yet to observe even incremental improvements in stability or performance. My work machine (which I'm using 8 hours a day) constantly needs gnome-shell restarts, and sometimes it locks up so bad I actually have to kill the whole session and lose everything I had open.  Recently my patience has worn thin enough that I started conspiring to try something (anything, really) new on my machine at work. The proverbial straw was broken when somehow my NVIDIA display drivers (custom installed in order to address a host of issues with gnome-shell) was broken so badly by an Ubuntu update that I had to boot into recovery to fix it. But wouldn't you know it, recovery console isn't working with my setup for some reason - it wouldn't detect my keyboard!

I had read about the [MATE](http://mate-desktop.org/) project on the Linux Mint blog a few months back, so today I wondered how it had come along. The prospect of a pure GNOME 2 environment running in the latest Ubuntu sounded very promising indeed. I decided it was finally time to make the jump.

With a small amount of tinkering, I had a fully functional MATE session up and running in Ubuntu 11.10.  It took a whopping 10 minutes to get MATE fully operational. All I had to do was the following:





  * sudo bash -c 'echo "deb http://tridex.net/repo/ubuntu/ oneiric main" >> /etc/apt/sources.list'


  * sudo apt-get update


  * sudo apt-get install mate-archive-keyring


  * sudo apt-get install mate-core


  * Logout, select MATE from the session list and log back in



The thing that struck me immediately is HOW INSANELY FAST IT IS. Especially compared to GNOME 3/Unity. After getting Compiz up and running and using the desktop for an hour or two, I suddenly realized just how sorely I'd missed the polished and refined awesomeness that is GNO- er, MATE.

I am in the process of installing MATE on my home machine now so I can get as much exposure to MATE as possible over the coming weeks. I will be documenting my experiences here, and sharing all the gotchas I find as I go.
