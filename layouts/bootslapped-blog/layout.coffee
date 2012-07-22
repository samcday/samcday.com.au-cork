doctype 5
html ->
	head ->
		meta charset: "UTF-8"
		link rel: "stylesheet", href: "/css/bootstrap.css"
		title "samcday.com.au"
	body ->
		div class: "container", ->
			div class: "row", ->
				div class: "span2", ->
					text "Sidebar."
				div class: "span10", ->
					div -> content
