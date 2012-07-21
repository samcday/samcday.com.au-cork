---
date: '2012-01-31 18:32:42'
layout: post
slug: glassfish-2-grails-2-logging
status: publish
title: Glassfish 2 & Grails 2 Logging
wordpress_id: '209'
categories:
- Grails
- Groovy
post_format:
- Standard
tags:
- Glassfish
- Grails
- Grails 2
- JUL
- Log4j
- Slf4j
---

Grails 2 is now released, and no doubt many people will be upgrading from 1.3.7 shortly. This blog post serves as a quick HOWTO on a fairly common issue involving deploying a Grails 2 app to a Glassfish 2 container. That issue is getting logging working correctly.

A quick rundown on how Grails 2 logging works:



	
  * [SLF4J](http://www.slf4j.org/) is used to handle logging

	
  * By default Grails uses [Log4j](http://logging.apache.org/log4j/1.2/) as the logging provider. 

	
  * [Jakarta Commons Logging (JCL)](http://commons.apache.org/logging/) is redirected to SLF4J using jcl-over-slf4j

	
  * java.util.logging is redirected to SLF4J in dev mode, but disabled in production environment by default




With this default setup, you'll quickly discover that Grails logging ends up in standard out in Glassfish, which means that you can't use Glassfish admin to configure log levels at all with your deployed application. This is obviously not an ideal situation.

Glassfish only supports java.util.logging, so we need to tell Grails to log to this in order to play nicely with Glassfish.

Previously in Grails 1.3.7, we were using the technique Reiney Sadder outlined in his [excellent blog post](http://blog.saddey.net/2010/03/27/how-to-deploy-a-grails-application-to-glassfish/) to remove log4j and install slf4j-jdk14 to redirect all logging to SLF4J into JUL. Unfortunately this technique no longer works in Grails 2, as Log4j support in Grails no longer comes from slf4j-log4j, but rather a core Grails plugin called "grails-plugin-log4j".

So, how do we achieve this in Grails 2? Simple! Just add the following to your BuildConfig.groovy:

[groovy]
// Inside your grails.project.dependency.resolution closure:

inherits("global") {
	if(Environment.current == Environment.PRODUCTION) {
		excludes "grails-plugin-log4j", "log4j"
	}
}
    
dependencies {
	if(Environment.current == Environment.PRODUCTION) {
		runtime "org.slf4j:slf4j-jdk14:1.6.4"
	}
}
[/groovy]

This will disable log4j entirely in production environment and add the slf4j-jdk14 JUL bridge. 

NOTE: Make sure you definitely have the following line added to your Config.groovy:

[groovy]
grails.logging.jul.usebridge = false
[/groovy]

You really should have this disabled for production anyway, as [it's not very performant](http://www.slf4j.org/legacy.html#jul-to-slf4j).

The BuildConfig.groovy change above completely disable log4j, so any log settings you have defined using the Log4j DSL in Config.groovy will not be recognized at all. This is why I only enabled it in production environment, it's still nice to be able to easily tweak logging settings for your development environment. If you really want to though, you can configure your own JUL logging.properties and just enable the SLF4J JUL bridge permanently.

Have fun!
