<element name="post-item">
    <div class="post-item">
        <!--<div
            class="post-item-image"
            style={'background-image': "url('https://thosakwe.com/content/images/2017/12/getty-ajit-pai-800x518.jpg')"}></div>-->
        <div class="post-item-body">
            <a href="/posts/" + post.stub>
                <h2 class="post-item-title">{{ post.title }}</h2>
            </a>
            <p>{{ post.description }}</p>
            <i>{{ post.dateString }}</i>
        </div>
    </div>
</element>