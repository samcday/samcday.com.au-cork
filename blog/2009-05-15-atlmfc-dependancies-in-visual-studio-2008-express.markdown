---
date: '2009-05-15 11:51:14'
layout: post
slug: atlmfc-dependancies-in-visual-studio-2008-express
status: publish
title: ATL/MFC dependancies in Visual Studio 2008 Express
wordpress_id: '9'
categories:
- Technology
---

Apparently, the Express versions of Visual Studio like to pretend there's no such thing as ATL or MFC. There's an easy workaround however.

First, download the Platform SDK at [http://www.microsoft.com/downloads/details.aspx?FamilyId=A55B6B43-E24F-4EA3-A93E-40C0EC4F68E5&displaylang;=en](http://www.microsoft.com/downloads/details.aspx?FamilyId=A55B6B43-E24F-4EA3-A93E-40C0EC4F68E5&displaylang=en)

You can deselect most of the components, just install the build environment for the Core Platform SDK. Add the PSDK\Include\atl and PSDK\Include\mfc directories to your build path in VC2008Exp.

Finally, follow the instructions at this URL: [http://www.codeproject.com/KB/wtl/WTLExpress.aspx](http://www.codeproject.com/KB/wtl/WTLExpress.aspx) from step 4 onwards.
