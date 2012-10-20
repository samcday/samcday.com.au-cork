h1 ->
	if isArchive then (a href: post.permalink, -> post.title or "") else text post.title or ""

i "#{post.date.getDate()}/#{post.date.getMonth()+1}/#{post.date.getFullYear()}"

text post.content

unless isArchive
	if prevPost
		a href: prevPost.permalink, -> "&laquo; #{prevPost.title}"
	if nextPost
		a href: nextPost.permalink, -> "#{nextPost.title} &raquo;"
