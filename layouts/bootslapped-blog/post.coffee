h1 ->
	if isArchive then (a href: post.permalink, -> post.title or "") else text post.title or ""

i "#{post.date.getDate()}/#{post.date.getMonth()+1}/#{post.date.getFullYear()}"

text post.content

if post.tags
	text "Tags: "
	first = true
	for tag in post.tags
		if first then first = false else text ", "
		a href: blog.tags[tag].permalink, -> tag

	br()

unless isArchive
	if prevPost
		a href: prevPost.permalink, -> "&laquo; #{prevPost.title}"
	if nextPost
		a href: nextPost.permalink, -> "#{nextPost.title} &raquo;"
