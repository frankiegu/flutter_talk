<extend src="layout.jl">
    <block name="head">
        <meta name="description" content=post.description>
        <style>
            /*footer {
                position: initial;
            }*/
        </style>
    </block>
    <block name="content">
        <include src="post-item.jl" />
        <div class="white">
            <main>
                <h1>{{ post.title }}</h1>
                <b class="subtitle">Tobe Osakwe &bull; {{ post.dateString }}</b>
                <div if=post.categories.isNotEmpty class="categories">
                    <span>Categories:</span>
                    <div for-each=post.categories>
                        <a href="/posts?category=" + item>{{ item }}</a>
                    </div>
                </div>
                <blockquote class="description">{{ post.description }}</blockquote>
                <br>
                <section>
                    {{- post.htmlContent }}
                </section>
                <!--<div id="comments">
                    <b id="comments-title">Loading comments...</b>
                </div>
                -->
                <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
                <ins class="adsbygoogle"
                     style="display:block; text-align:center;"
                     data-ad-layout="in-article"
                     data-ad-format="fluid"
                     data-ad-client="ca-pub-2116133816688639"
                     data-ad-slot="8309580533"></ins>
                <script>
                     (adsbygoogle = window.adsbygoogle || []).push({});
                </script>
                <div id="disqus_thread" style="padding: 2em 0"></div>
                <script>

                /**
                *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
                *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables*/
                /*
                var disqus_config = function () {
                this.page.url = 'https://flutter.thosakwe.com/posts/{{ post.stub }}';  // Replace PAGE_URL with your page's canonical URL variable
                this.page.identifier = '{{ post.stub }}'; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
                };
                */
                var d = document, s = d.createElement('script');
                s.src = 'https://flutter-talk.disqus.com/embed.js';
                s.setAttribute('data-timestamp', +new Date());
                (d.head || d.body).appendChild(s);
                </script>
                <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
            </main>
            <script>
                hljs.initHighlighting.called = false;
                hljs.initHighlighting();
            </script>
        </div>
    </block>
</extend>