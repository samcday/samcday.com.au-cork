for post in posts
	text post

if page > 1
	a href: "/blog/page/#{page-1}", -> "&laquo; Prev Page"
if page < totalPages
	a href: "/blog/page/#{page+1}", -> "Next Page &raquo;"
