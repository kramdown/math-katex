**Important: This repo and gem are unmaintained! If you are interested in
maintaining, please contact me at <t_leitner@gmx.at>.**

# kramdown math engine for conversion to HTML

This is a converter for [kramdown](https://kramdown.gettalong.org) that uses
[KaTeX](https://khan.github.io/KaTeX/) and the [katex
gem](https://github.com/glebm/katex-ruby) to convert math formulas to HTML on
the server side.

Note: Until kramdown version 2.0.0 this math engine was part of the kramdown
distribution.


## Installation

~~~ruby
gem install kramdown-math-katex
~~~


## Usage

~~~ruby
require 'kramdown'
require 'kramdown-math-katex'

Kramdown::Document.new(text, math_engine: :katex).to_html
~~~


## Documentation

The engine uses [KaTeX] via the [katex rubygem][katex-gem] to convert TeX math formulas into KaTeX
HTML, using [ExecJS] under the hood. This eliminates the need for client-side math-rendering
Javascript. This engine is somewhat similar to the [SsKaTeX] math engine, but easier to use and
suitable for kramdown input from untrusted users.

Requirements for running kramdown with math engine KaTeX:

- Ruby gem `kramdown-math-katex`
- Ruby gem [`katex`][katex-gem],
- Ruby gem [`execjs`][ExecJS],
- A Javascript engine supported by ExecJS, e.g. via one of
  - Ruby gem [`therubyracer`][therubyracer],
  - Ruby gem [`therubyrhino`][therubyrhino],
  - Ruby gem [`duktape`][duktape],
  - [Node.js].

All these requirements need to be met only if KaTeX is actually used. Note that the [`katex`
gem][katex-gem] includes [KaTeX]'s Javascript, CSS, and fonts; those do not need to be installed
separately. Your HTML templates still need to reference the KaTeX CSS. Consult the [`katex` gem's
documentation][katex-gem#assets] on how to do that.

A typical KaTeX configuration looks like this:

~~~ yaml
math_engine: katex
math_engine_opts: {}
~~~

`math_engine_opts` are passed directly to `Katex.render`. See the gem's [documentation][katex-gem]
for more information.

If you need to sanitize the output, see [this example][sanitize-example] for inspiration.

[duktape]: https://github.com/judofyr/duktape.rb#duktaperb
[ExecJS]: https://github.com/rails/execjs#execjs
[KaTeX]: https://khan.github.io/KaTeX/
[katex-gem]: https://github.com/glebm/katex-ruby
[katex-gem#assets]: https://github.com/glebm/katex-ruby#assets
[sanitize-example]: https://github.com/thredded/thredded-markdown_katex/blob/2f5e748c90265526171a6da99557f637d2b717ec/lib/thredded/markdown_katex.rb#L48-L91
[SsKaTeX]: sskatex.html
[therubyracer]: https://github.com/cowboyd/therubyracer#therubyracer
[therubyrhino]: https://github.com/cowboyd/therubyrhino#therubyrhino
[Node.js]: https://nodejs.org/


## Development

Clone the git repository and you are good to go. You probably want to install
`rake` so that you can use the provided rake tasks.


## License

MIT - see the **COPYING** file.
