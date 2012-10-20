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
	br()

text """
<div id="disqus_thread"></div>
<script type="text/javascript">
    /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
    var disqus_shortname = 'samcdaycomau'; // required: replace example with your forum shortname

    /* * * DON'T EDIT BELOW THIS LINE * * */
    (function() {
        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
        dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
    })();
</script>
<noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
<a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>
"""