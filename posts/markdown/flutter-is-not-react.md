## Contents
* [Dart is not JavaScript](#dart-is-not-javascript)
    * [Inheritance + Polymorphism](#inheritance--polymorphism)
    * [Constant classes are cached](#constant-classes-are-cached)
    * [Classes are their own types](#classes-are-their-own-types)
* [Redux isn't idiomatic Dart](#redux-isnt-idiomatic-dart)
* [Not a WebView](#not-a-webview)
* [No XML syntax](#no-xml-syntax)
* [Dart has `async` built in](#dart-has-async-built-in)
* [Conclusion](#conclusion)

By now, it would be a surprise if you hadn't heard of
[Flutter](https://flutter.io), Google's framework for building cross-platform
mobile apps in the Dart language. It's been marketed heavily over the past several
months, has sparked hundreds of discussions, and has quickly made its way into
the top 100 starred repositories on Github.

Besides Flutter's "write once, run anywhere" appeal, perhaps the feature of Flutter
that is most notable is its tree-like structure of *widgets*. User interfaces aren't built
imperatively, but declaratively, in a tree that might remind you of another UI building
framework... *React*.

Many have noted that Flutter's structure is, at first glance, similar to that of React's.
In fact, Flutter was inspired by React [[1]], and the two both frameworks both share concepts
of unidirectional data flow, and a distinction between stateless and stateful components.

#### However, in practice, this is where the similarities **end**.

## Dart is not JavaScript
Simply put, the *biggest* difference between Flutter and React is the programming language
used to build applications with each framework.

Whereas React components generally tend to be stateless functions:

```javascript
const profileInfo = ({user}) => {
  return (
    <div>
      <b>Welcome back!<b>
      <UserAvatar user={user} />
    </div>
  );
};
```

Flutter widgets tend to be classes (which may or may not hold their state):

```dart
class ProfileInfo extends StatelessWidget {
  final User user;
  
  ProfileInfo({@required this.user});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome back!',
          style: TextStyle(fontWeight: FontWeight.bold)
        ),
        UserAvatar(user: user),
      ],
    );
  }
}
```

While neither is strictly "better" than the other, because classes are first-class citizens
in Dart, implementing widgets as classes rather than functions affords several advantages:

### Inheritance + Polymorphism
Inheritance and polymorphism allow widgets to easily share common functionality, and
override specific parts of said functionality:

For example, if you had a base class for widgets that show a navigation bar:

```dart
class WidgetWithNavbar extends StatelessWidget {
  Widget buildNavbar(BuildContext context) {
    return Text('This would be a navbar');
  }
  
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Navbar below:'),
      buildNavbar(context),
    ]);
  }
}
```

You could extend it with custom logic to render different navigation bars in different
situations:

```dart
class WidgetWithButtonInsteadOfNavbar extends WidgetWithNavbar {
  @override
  Widget buildNavbar(BuildContext context) {
    return FlatButton(child: Text('Not a navbar!'));
  }
}
```

### Constant classes are cached
Classes can be constants in Dart, and therefore stored in lookup tables [[2]], rather than
re-instantiated every time they are called. This yields better performance for frequently-called
widgets, like `Text`, `Icon`, and others.

### Classes are their own types
In Dart, Java, and any language with classes as truly first-class citizens, classes are
their own, unique types in the type system. This makes the common `<X>.of` dependency injection
pattern possible, as you can query a parent widget by its type, rather than having to manually
pass down multiple properties, like you might have to in React when not using Redux/Mobx/any
state management library.

Take a look at the `FrogColor` pseudo-code from the Flutter `InheritedWidget` documentation
[[3]]:

```dart
class FrogColor extends InheritedWidget {
  const FrogColor({
    Key key,
    @required this.color,
    @required Widget child,
  }) : assert(color != null),
       assert(child != null),
       super(key: key, child: child);

  final Color color;

  static FrogColor of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(FrogColor);
  }

  @override
  bool updateShouldNotify(FrogColor old) => color != old.color;
}
```

## Redux isn't idiomatic Dart
Because React, like Flutter, lends itself to unidirectional data flow (from parent to child,
and *never* the other around), it makes it possible to have components where you pass down
literally dozens of read-only attributes *and* value-change callbacks:

```javascript
const wtf = () => {
  return (
    <div>
      <SomeComponent
        foo={foo}
        bar={bar}
        baz={franken.stein}
        title={title}
        user={user}
        fooChange={(foo) => setState({foo})}
        barChange={(bar) => setState({bar})}
        bazChange={(baz) => setState({franken: {... this.state.franken, stein: baz}})}
        titleChange={(title) => setState({title})}
        userChange={(user) => setState({user})}/>
    </div>
  );
};
```

This can easily get messy and cumbersome, so libraries like Redux emerged that allow you to
separate state operations into *reducers*, and instead structure your UI using less complex
callbacks, and instead only deal with one global application state:

```javascript
const myReducer = (state = {foo: bar}, action) => {
  switch (action.type) {
    case 'changeUser':
      return {...state, user: action.value};
    default:
      return state;
  }
};
```

Now, Redux is nice in complex applications, but the main reason it works well is that it
*takes advantage of the features of the language it uses*, a.k.a. JavaScript. Reducers
are easy to write because JavaScript objects have anonymous types, there is a nifty object
spread (`...`) operator, there is no rule on the order of parameters with and without default
values, and that JavaScript's features facilitate the `combineReducers` pattern.

#### *None* of this is present in Dart!

From day one, Dart has served different purposes than JavaScript, and especially with the
advent of Dart 2 and strong mode ([[4]]), the dynamic typing that Redux is designed to work
with is all but impossible. Thus, using Redux in Dart requires a great deal more boilerplate
than it does in JavaScript (which was already a lot before), as well as multiple code generators,
and extra complications to ensure that no operations create static typing errors.

*Idiomatic* Dart, however, doesn't shy away from the static typing, but instead embraces it,
and uses *built-in* functionality, like Streams and the aforementioned `X.of` pattern to
pass data throughout the UI tree.

Treating Flutter as merely an extension of React in this case will do nothing more for you
than bring in boatloads of confusion to your project, which is probably not favorable for you
if you're learning Dart for the first time.

## Not a WebView
Yet another major difference between Flutter and React (both React for the Web
and React Native) is that while React  is a virtual
DOM designed to render to HTML, Flutter is a different beast entirely, drawing its own widgets,
like a game would. This makes it easier to build fast, responsive, UI's, right from the jump,
as Flutter doesn't have to compensate for the abstraction that the HTML DOM provides.

## No XML syntax
As an extension of [the above point](#not-a-webview), Dart has no XML-like syntax,
because **it is not producing XML or any other markup**.

For a while, there has been a quite heated discussion open about adding
a "DSX" syntax to Flutter [[5]], and I highly doubt that it will end throughout the
entire lifespan of the Flutter project.

While it might seem "intuitive" to represent Flutter widgets as XML, it is important to keep
in mind that:
* Flutter is not creating any XML at all, so this is a misleading and inaccurate representation
of the actual widgets in the tree.
* Dart has many use cases outside of Flutter; adding this feature to the language means that
provisions have to be made for it both in Dart4Web and Dart on the server, two domains where it
makes little to no sense at all to have Flutter-specific syntax in the language.
    * This is further complicated by the fact that for a long time, the different Dart
    backends weren't using the same front-end, so features like pre-processing Dart code
    are not feasible in the current setup (if ever).
* Flutter is not React; importing a React-specific solution into Dart ignores the differences
between Dart and JavaScript, and adds another potential point of breakages in the future.
* What if Flutter is not in use in 10 years? It would then become a problem to try to remove
the "DSX" code from the Dart ecosystem, as it would inevitably become totally obsolete and
useless.

## Dart has `async` built in
As briefly touched upon earlier, the Dart standard libraries include `dart:async`, which bundles
features like `Future`, `Stream`, and `scheduleMicrotask` into the language itself, without
needing polyfills (unlike `Promise`, `EventEmitter`, etc.).

To transfer state between components, instead of hacking in features from dynamic languages, we
can use `dart:async` features to move data in a type-safe fashion:

For example, if we have only *one* widget in our hierarchy that tracks its state, it can
pass `StreamController` instances down, rather than callback functions:

```dart
class MyApp extends StatefulWidget {
  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final StreamController<String> _titleChange = new StreamController<String>();
  
  String title;
  
  @override
  void initState() {
    super.initState();
    _titleChange.stream.listen((newTitle) {
      // `dart:async` takes care of issuing and calling this callback for us!
      // We just have to call `setState`.
      setState(() => title = newTitle);
    });
  }
  
  @override
  void deactivate() {
    _titleChange.close();
    super.deactivate();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: TheBody(
        title: title,
        titleChange: _titleChange
      ),
    );
  }
}
```

Though, if we pass down multiple `StreamController` instances every time, things can
quickly become ugly. We can take advantage of Dart's classes and wrap them all into one class
that can be provided to the `_MyAppState` class:

```dart
class AppChanges {
  final StreamController<String> titleChange = new StreamController<String>();
  
  Stream<String> get onTitle => titleChange.stream;
}
```

Even this, though, might feel a little bit bare-bones, so instead of passing the `AppChanges`
class down throughout the *entire hierarchy*, re-visit the
[`X.of` pattern]() and `InheritedWidget` to reliably provide each widget in your tree,
as a sort of dependency injection.

As mentioned before, this lets us take advantage of [constant classes](#constant-classes-are-cached):

```dart
class SomeChildWidget extends StatelessWidget {
  const SomeChildWidget();
  
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('Click me!!!'),
      onPressed: () {
        AppChanges.of(context).titleChange.add('New title here');
      },
    );
  }
}
```

This pattern is far more elegant than passing objects down throughout the tree, and easier
to make sense of than wrapping widgets in `provide` calls, like is done in Redux.

[`package:immutable_state`](https://github.com/thosakwe/immutable_state) is my own attempt at
a lightweight library for transferring state throughout an application, using only
`Stream` and `X.of`. It is not a lot of code, and if need be, you can even write your own,
application-specific version in a matter of minutes.

## Conclusion
React is great; Flutter is, too. But while they share some elements of design philosophy,
they really are not equivalent, and shouldn't be treated as such. Pretending that Flutter
is just a faster React Native will quickly make things confusing for you and your team, and
while it might feel familiar at first, you'll soon find that patterns native to JavaScript don't
gel as smoothly to Dart as you once thought they may have.

To unlock the full power of Flutter, and to continue to be productive with the framework as it
grows into the future, it's extremely important to understand the nature of the project, and
use it for what it is, rather than trying to mold it it into practices that don't apply the
same way in a statically-typed language.

## Notes
This is my first article on this new blog, and my first article about Flutter ever. Hopefully
you liked it and found it informative. But if not, then feel more than free to leave a comment
below!

You can find me on Twitter, Github, YouTube, or virtually any other social medium or
communication channel, so for questions, comments, or even hate mail, don't be afraid to go
looking for me.

[1]: https://flutter.io/widgets-intro/
[2]: https://stackoverflow.com/a/21745617/5673558
[3]: https://docs.flutter.io/flutter/widgets/InheritedWidget-class.html
[4]: https://www.dartlang.org/guides/language/sound-dart
[5]: https://github.com/flutter/flutter/issues/11609