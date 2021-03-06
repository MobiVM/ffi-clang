# -*- coding: utf-8 -*-
# Copyright, 2010-2012 by Jari Bakken.
# Copyright, 2013, by Samuel G. D. Williams. <http://www.codeotaku.com>
# Copyright, 2013, by Garry C. Marshall. <http://www.meaningfulname.net>
# Copyright, 2014, by Masahiro Sano.
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'ffi/clang/lib/source_range'

module FFI
	module Clang
		class SourceRange
			def self.null_range
				SourceRange.new Lib.get_null_range
			end

			def initialize(range_or_begin_location, end_location = nil)
				if end_location.nil?
					@range = range_or_begin_location
				else
					@range = Lib.get_range(range_or_begin_location.location, end_location.location)
				end
			end

			def start
				ExpansionLocation.new(Lib.get_range_start @range)
			end

			def end
				ExpansionLocation.new(Lib.get_range_end @range)
			end

			def null?
				Lib.range_is_null(@range) != 0
			end

			attr_reader :range

			def ==(other)
				Lib.equal_range(@range, other.range) != 0
			end
		end
	end
end
