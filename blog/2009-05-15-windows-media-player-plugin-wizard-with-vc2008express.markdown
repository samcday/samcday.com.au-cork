---
date: '2009-05-15 10:51:12'
layout: post
slug: windows-media-player-plugin-wizard-with-vc2008express
status: publish
title: Windows Media Player Plugin Wizard with VC2008Express
wordpress_id: '8'
categories:
- Technology
---

So I couldn't figure out how to get the Windows Media Player Plugin Wizard that ships with the Windows SDK to show up in Visual C++ 2008 Express. I was following the instructions found @ [http://msdn.microsoft.com/en-us/library/aa969509(VS.85).aspx](http://msdn.microsoft.com/en-us/library/aa969509(VS.85).aspx) but it still wasn't showing.

My problem is I was putting the wmpwiz files in C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcprojects and not C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\**Express**\VCProjects. Someone's probably going to tell me I'm stupid, and you know what? They're probably right.

Also to get the Wizard working, use the wmpwiz2005.vsz file, and change the second line from

Wizard=VsWizard.VsWizardEngine.8.0

to

Wizard=VsWizard.VsWizardEngine.9.0
