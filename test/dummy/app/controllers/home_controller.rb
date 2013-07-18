class HomeController < ApplicationController
  def index
  	landmark_track("Home!", {:foo => 1000})
  end
end
