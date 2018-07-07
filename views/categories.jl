<extend src="layout.jl">
    <block name="content">
        <main>
            <h1 class="title">Categories ({{ categories.length }})</h1>

            <blockquote if=categories.isEmpty class="blue">
                No categories were found matching the given criteria.
            </blockquote>

            <ul>
                <li for-each=categories as="category">
                    <a href="/posts?category=" + category class="always blue">{{ category }}</a>
                </li>
            </ul>
        </main>
    </block>
</extend>