# -*- coding: utf-8; frozen_string_literal: true -*-
#
#--
# Copyright (C) 2018 Gleb Mazovetskiy <glex.spb@gmail.com>
#
# This file is part of kramdown-math-katex which is licensed under the MIT.
#++

require 'kramdown/converter'
require 'katex'

module Kramdown::Converter #:nodoc:
  module MathEngine #:nodoc

    # Uses the KaTeX gem for converting math formulas to KaTeX HTML.
    module Katex

      VERSION = '1.0.1'

      def self.call(converter, el, opts)
        display_mode = el.options[:category] == :block
        result = ::Katex.render(
          el.value,
          display_mode: display_mode,
          throw_on_error: false,
          **converter.options[:math_engine_opts]
        )
        attr = el.attr.dup
        attr.delete('xmlns')
        attr.delete('display')
        result.insert(result =~ /[[:space:]>]/, converter.html_attributes(attr))
        result = "#{' ' * opts[:indent]}#{result}\n" if display_mode
        result
      end

    end

  end

  add_math_engine(:katex, MathEngine::Katex)

end
