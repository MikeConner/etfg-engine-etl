class KnownExceptionsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @exceptions = KnownException.order('datasource_id DESC')
     
    render :layout => 'admin'
  end
  
  def bulk_update
    puts params
    
    redirect_to known_exceptions_path, :notice => 'Data file updated'
  end
end
