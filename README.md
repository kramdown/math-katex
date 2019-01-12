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


## Development

Clone the git repository and you are good to go. You probably want to install
`rake` so that you can use the provided rake tasks.


## License

MIT - see the **COPYING** file.
