class ApiUsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = ApiUser.order(:username)
    
    render :layout => 'admin'
  end
end
