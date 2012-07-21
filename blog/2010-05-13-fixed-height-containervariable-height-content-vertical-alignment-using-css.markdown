---
date: '2010-05-13 10:38:55'
layout: post
slug: fixed-height-containervariable-height-content-vertical-alignment-using-css
status: publish
title: Fixed-height container/variable-height content Vertical Alignment using CSS
wordpress_id: '104'
categories:
- CSS
- Technology
- Web
tags:
- cross browser
- iesucks
- standards compliant
- vertical alignment
---

Whew. The title is a bit long-winded eh?

This short blog post highlights how to vertically center variable-height block-level content inside a fixed height container, in a cross-browser, (mostly) standards compliant manner.

I've lost count of how many times I've needed to do this. Seriously. For example, you may have a block of text, or an image or two that need to sit nicely in a container you've allocated for it. For quite a while now, all standards-compliant browsers have had support for the **display: table** CSS declaration, which makes vertical alignment a snap. Unfortunately though, Internet Explorer is way behind in the game, with both IE6+7 not supporting this declaration. There is hope however!

I have stumbled across the following page a few times now, it's the best resource I've found on how to overcome this problem.

[http://www.jakpsatweb.cz/css/css-vertical-center-solution.html](http://www.jakpsatweb.cz/css/css-vertical-center-solution.html)

I've adapted this solution into a set of 2 CSS files that I now use when I need to vertically center something.

**valign.css**
[css]
div.valignContainer {
	display: table;
	overflow: hidden;
}

div.valignMiddle {
	display: table-cell;
	vertical-align: middle;
}
[/css]

**valign_ie.css**
[css]
div.valignContainer {
	position: relative;
}

div.valignMiddle {
	position: absolute;
	top: 50%;
}

div.valignInner {
	position: relative;
	top: -50%;
}
[/css]

Include it in the page like so:
[php htmlscript="true"]
<link rel="stylesheet" href="valign.css" type="text/css"/>
<!--[if lte IE 7]>
<link rel="stylesheet" href="valign_ie.css" type="text/css"/>
<![endif]-->
[/php]

To use this solution, let's say you currently had markup like so:
[php htmlscript="true"]
<div id="myContainerThatSpecifiesAppearanceAndDimensions">
  <div id="myContentThatNeedsTobeVerticallyCentered">
    Content that should be vertically centered!
  </div>
</div>
[/php]

You would change it to the following:
[php htmlscript="true"]
<div id="myContainerThatSpecifiesAppearanceAndDimensions" class="valignContainer">
  <div class="valignMiddle">
    <div id="myContentThatNeedsTobeVerticallyCentered" class="valignInner">
      Content that should be vertically centered!
    </div>
  </div>
</div>
[/php]

That's all, folks!

