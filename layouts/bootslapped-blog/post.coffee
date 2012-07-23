h1 ->
	if isArchive then (a href: post.permalink, -> post.title) else text post.title

text post.content

unless isArchive
	if prevPost
		a href: prevPost.permalink, -> "&laquo; #{prevPost.title}"
	if nextPost
		a href: nextPost.permalink, -> "#{nextPost.title} &raquo;"
