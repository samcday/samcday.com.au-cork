h1 (if type is "category" then "Category: #{name}" else if type is "tag" then "Tag: #{name}")
for post in posts
	text post.title
	br()