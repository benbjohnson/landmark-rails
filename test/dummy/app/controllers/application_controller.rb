class ApplicationController < ActionController::Base
  protect_from_forgery
  include Landmark::Rails::Helpers
  landmark()
end
