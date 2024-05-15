class HomeController < ApplicationController

  before_action :authenticate_user!
  def all_users
    @users = User.all
  end

  def follow_request
    
  end

  def current_profile

  end
  
end
