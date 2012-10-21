doctype 5
html ->
	head ->
		meta charset: "UTF-8"
		link rel: "stylesheet", href: "/css/bootstrap.css"
		title "samcday.com.au"
		text """
		<script type="text/javascript">

		  var _gaq = _gaq || [];
		  _gaq.push(['_setAccount', 'UA-33331464-1']);
		  _gaq.push(['_trackPageview']);

		  (function() {
		    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		  })();

		</script>
		"""
	body ->
		div class: "container", ->
			h1 -> a href: "/blog", -> "samcday.com.au"
			div class: "row", ->
				div class: "span2", ->
					h2 "Categories"
					ul ->
						for category in _meta.blog.categories
							li -> 
								a href: category.permalink, -> category.name
								i -> " (#{category.count})"
				div class: "span10", ->
					div -> content