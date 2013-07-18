class ApplicationController < ActionController::Base
  protect_from_forgery
  include Landmark::Rails::Helpers
  before_filter :landmark_identify_and_track_page
end
