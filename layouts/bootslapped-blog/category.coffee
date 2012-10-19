h1 (if type is "category" then "Category: #{name}" else if type is "tag" then "Tag: #{name}")

# Collect up the years covered in this category.
postsByDate = {}

if posts
	for post in posts
		year = post.date.getFullYear()
		month = post.date.getMonth() + 1
		day = post.date.getDate() + 1
		postsByDate[year] ?= {}
		postsByDate[year][month] ?= []
		postsByDate[year][month].push post

for year, months of postsByDate
	h2 -> "#{year}"
	for month, monthPosts of months
		h2 -> "#{month}"
		for post in monthPosts
			text post.title
