h1 (if type is "category" then "Category: #{name}" else if type is "tag" then "Tag: #{name}")

monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

# Collect up the years covered in this category.
postsByDate = {}

# TODO: could do this in a less sucky way using underscore.
if posts
	for post in posts
		year = post.date.getFullYear()
		month = post.date.getMonth() + 1
		day = post.date.getDate() + 1
		postsByDate[year] ?= {}
		postsByDate[year][month] ?= []
		postsByDate[year][month].push post

years = _.sortBy _.keys postsByDate

for year in years
	h2 -> "#{year}"
	months = _.sortBy _.keys postsByDate[year]
	for month in months
		h3 -> "#{monthNames[parseInt(month) - 1]}"
		ul ->
			for post in postsByDate[year][month]
				li ->
					a href: post.permalink, -> post.title
