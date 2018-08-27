class IssuerExceptionsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @exceptions = IssuerException.order('file_date DESC')
     
    render :layout => 'admin'
  end
  
  def bulk_update
    puts params
    
    redirect_to issuer_exceptions_path, :notice => 'Data file updated'
  end
end
