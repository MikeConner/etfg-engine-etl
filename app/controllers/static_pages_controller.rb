class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def workbench
    render :layout => 'admin'
  end
end
