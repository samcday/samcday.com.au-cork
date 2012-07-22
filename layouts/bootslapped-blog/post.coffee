h1 -> post.title

text post.content

if prevPost
	text "prev post yo: #{prevPost.title}"

if nextPost
	text 
	text "next post yo! #{nextPost.title}"