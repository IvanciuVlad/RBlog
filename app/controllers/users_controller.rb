class UsersController < ApplicationController
  def my_friends
    @friends = current_user.friends
  end
end
