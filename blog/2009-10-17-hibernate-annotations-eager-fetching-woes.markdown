---
date: '2009-10-17 17:57:44'
layout: post
slug: hibernate-annotations-eager-fetching-woes
status: publish
title: Hibernate Annotations Eager Fetching Woes
wordpress_id: '11'
categories:
- Hibernate
- Technology
---

So I've been working on a moderately complicated Java EE project utilizing Spring + Hibernate + GWT lately. I ran into an issue lately that got me more frustrated than I have been in quite a while.

The project is primarily all about information modelled for a particular industry in Australia. There's a decent amount of information stored. There's a handful of root entities that have lots of Set's of other entities. The semantics in the way this data is administered via GWT and RPC mechanisms persuaded me to opt for fetching all information in the main entities EAGERly. I didn't notice it at first but once I the MySQL database started with fill with data  I noticed that latency and memory usage in the app was climbing exponentially.

Another bizarre issue was that calling list() on the root entities would return large amounts of duplicates. After Googling I found out this was because of the @CollectionOfElements and @OneToMany entity mappings I was using. Furthermore, some of the root entities were referenced by other root entities, and when loading the assosciation between the two root entities, I'd be getting horrendous lag followed by a painful java.lang.OutOfMemory exception.

For other reasons I had completely ruled out reverting back to LAZY loading mechanisms on the data, so I had to spend a few hours trying to fix the problem. The godsend was a comment made by "Andrey Trubin" at this URL: [http://stackoverflow.com/questions/1093153/hibernate-collectionofelements-eager-fetch-duplicates-elements](http://stackoverflow.com/questions/1093153/hibernate-collectionofelements-eager-fetch-duplicates-elements)

As it happens, annotating all @CollectionOfElements and @OneToMany fields with @Fetch(FetchMode.SELECT) eliminated all my headaches. It might have a bit of a performance hit on your data loading, but in my case this was neglible to actually having a data access layer that works :)

Hope this helps someone!
