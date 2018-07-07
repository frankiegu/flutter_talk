<extend src="layout.jl">
    <block name="content">
        <main>
            <h1 if=status == 404 class="title">Whoops! That page doesn't exist.</h1>
            <h1 if=status != 404  class="title">Whoops! Something's not right.</h1>
            <p if=status == 404>
                Perhaps you were given a dead link, or made a typo.
                That's all good and well; just click the link below to get to the right place!
            </p>
            <p if=status != 404>
                Believe me... We're working on it...
            </p>
            <a href="/" class="always blue">Return home</a>
        </main>
    </block>
</extend>