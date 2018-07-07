![Flutter talk](web/images/logo.png)

Learn Flutter today, with tutorials, videos, and interactive exercises for the hottest mobile framework.

## About
This is the source code repository for
[Flutter Talk](https://flutter.thosakwe.com), a new blog about Flutter and everything
related to Dart.

The site is powered by a simple, Markdown-based blog engine built with the open-source
[Angel framework](https://angel-dart.github.io) for Dart server-side development.

## Running
The site should be ready-to-go out of the box; it uses no database, and all functionality
is Dart-based.

This project is aimed at version `2.0.0-dev.59.0` of the Dart SDK. I believe that it may
work up to `2.0.0-dev.61.0` or even further, but the Angel framework is currently blocked on
several issues in later versions of the Dart SDK, and therefore cannot be updated yet to
*fully* run on `2.0.0-dev.64.0` and later.

## Caching
You may notice that pages stay completely the same after refresh, and don't change!
This project makes much of use caching within the HTTP protocol, and via a server-side cache of
articles.

All problems can be resolved with a simple restart of the server.

## Turbolinks
In a future release, Turbolinks *may* be added to further speed up the site; however, it
seems to be incompatible with AdSense, and frankly, this blog needs money to survive.

Until then, load times should be more than fast enough with the caching functionality already
in place.