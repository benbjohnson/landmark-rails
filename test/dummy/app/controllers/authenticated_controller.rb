class AuthenticatedController < ApplicationController
  def index
  end

  def current_user
    user = AuthenticatedUser.new()
    user.id = 123
    return user
  end
end


class AuthenticatedUser
  attr_accessor :id
end