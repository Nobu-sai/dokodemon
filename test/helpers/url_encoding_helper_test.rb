require 'test_helper'
include UrlEncodingHelper

class UrlEncodingHelperTest < ActionDispatch::IntegrationTest

	test "url_encoding Helper Test" do
		encoding_user_name = "Mr.+*#$$#'('•º≠ç˙¬˚" 
		encoded_user_name = url_encoding("#{encoding_user_name}")
		encoding_blog_title = "BLOG-TITLE"
		encoded_blog_title = url_encoding("#{encoding_blog_title}")
		
		assert_routing "/#{encoded_user_name}/blog/#{encoded_blog_title}", 
		  controller: 'blogs', 
		  action: 'show', 
		  username: "#{encoded_user_name}",
		  title: "#{encoded_blog_title}"

	end

end
  