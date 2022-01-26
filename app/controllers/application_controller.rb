

class ApplicationController < ActionController::Base
  include SessionsHelper
  include SessionStorePathService
  include UserShouldLogInPolicy
  
end