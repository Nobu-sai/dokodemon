require 'active_support/core_ext/string/inflections'
require 'byebug'

module UrlEncodingHelper
	def url_encoding(url_string)		
		url_string.parameterize(separator: '_', preserve_case: true)
	end


end