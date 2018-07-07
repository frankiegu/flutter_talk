<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title if=title != null>{{ title }} | Flutter Talk</title>
    <title if=title == null>Flutter Training</title>
    <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/atom-one-light.min.css">
    <link rel="stylesheet" href="/css/site.css">
    <link rel="icon" href="/images/favicon.png">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="flutter,dart,angel,mobile development,react,react native,apps,app development,ios,programming,coding,cross-platform,xamarin,cordova,aqueduct,jaguar,shelf,google,github,sdk,libs,library,android,mobile,app store">
    <block name="head"></block>
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-68026607-10"></script>
    <script async src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js"></script>
    <script async src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/languages/dart.min.js"></script>
    <script async src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/languages/javascript.min.js"></script>
    <script async src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/languages/yaml.min.js"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
        gtag('config', 'UA-68026607-10');
    </script>
</head>
<body unresolved>
    <div class="wrapper">
        <include src="nav-bar.jl" />
        <main>
            <block name="content"></block>
        </main>
    </div>
    <footer>
        &copy;
        <a class="always blue" href="https://thosakwe.com" target="_blank">Tobe Osakwe</a>
        {{ year }}.
        Proudly powered by
        <a class="always blue" href="https://angel-dart.github.io" target="_blank">Angel.</a>
    </footer>
    <!--
    <div class="footer segment">
        <span class="copyright">&copy; {{year}} <a href="https://thosakwe.com" target="_blank">Tobechukwu Osakwe</a></span>
        <br>
        <ul>
            <li>
                <a href="https://github.com/thosakwe" target="_blank"><i class="fa fa-github"></i></a>
            </li>
            <li>
                <a href="https://twitter.com/thosakwe" target="_blank"><i class="fa fa-twitter"></i></a>
            </li>
            <li>
                <a><i class="fa fa-youtube"></i></a>
            </li>
        </ul>
    </div>
    -->
</body>
</html>