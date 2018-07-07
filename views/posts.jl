<extend src="layout.jl">
    <block name="content">
        <include src="post-item.jl" />
        <declare posts=pagination.data>
            <main>
                <h1 if=category == null class="title">Newest Posts ({{ posts.length }})</h1>
                <h1 if=category != null class="title">Category:{{ category }} ({{ posts.length }})</h1>

                <blockquote if=posts.isEmpty class="blue">
                    No posts were found matching the given criteria.
                </blockquote>

                <div class="post-list">
                    <post-item class="post-item-container" for-each=posts @post=item />
                </div>

                <a
                    if=hasNextPage
                    class="always blue"
                    href="/posts/?page=" + pagination.nextPage>
                    next page
                </a>
            </main>
        </declare>
    </block>
</extend>