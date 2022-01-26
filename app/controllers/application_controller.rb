

class ApplicationController < ActionController::Base
  include SessionsHelper
  include SessionTrackPagePathPolicy
  include LoggedInUserPolicy
  
  before_action :track_page_path
    # For
      # - Redirecting or Rendering the Page based on the PREVIOUS Page where the user came FROM 
end