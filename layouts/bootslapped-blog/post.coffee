h1 ->
	if isArchive then (a href: post.permalink, -> post.title or "") else text post.title or ""

text post.content

unless isArchive
	if prevPost
		a href: prevPost.permalink, -> "&laquo; #{prevPost.title}"
	if nextPost
		a href: nextPost.permalink, -> "#{nextPost.title} &raquo;"
