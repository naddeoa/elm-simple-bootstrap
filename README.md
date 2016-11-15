Simple elm interface for Twitter's bootstrap library
===

This package exposes a few modules that allow you to create html with bootstrap
classes. In writing my first elm application (a web interface to the gnome
hamster time tracker) I found that I was hard coding a lot of twitter bootstrap
classes everywhere without knowing whether or not the element could benefit from
that class. Does `form-group` go on the div around a form input, or on the form
itself? Can anything have a `bg-danger` or only divs? This library is an attempt
at answering those questions with some type safety via the `Boostrap.Properties`
module in this library.

This is the first version of my first package, so things will
definitely change

## See also
* [Elm docs][elm_docs] page
* [Boostrap CSS documentation][bootstrap_documentation] page. Currently, this library is based on v 3.3.7 of Bootstrap.

[elm_docs]: http://package.elm-lang.org/packages/naddeoa/elm-simple-bootstrap
[bootstrap_documentation]: http://getbootstrap.com/css/
