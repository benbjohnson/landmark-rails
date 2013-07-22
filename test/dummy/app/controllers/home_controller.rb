class HomeController < ApplicationController
  before_filter {|c| c.disable_landmark if params[:notrack] == "true"}

  def index
    landmark_track("Home!", {:foo => 1000})
  end
end
