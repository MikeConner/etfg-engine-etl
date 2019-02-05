class AssetClassLookupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @mappings = AssetClassLookup.order(:security_type)
    @lookup = AssetClassLookup.new
    
    render :layout => 'admin'
  end
  
  def create
    @mapping = AssetClassLookup.new(asset_class_params)

    if @mapping.save
      redirect_to asset_class_lookups_path, :notice => 'Lookup table entry added'
    else
      redirect_to asset_class_lookups_path, :alert => "Error adding entry! #{@mapping.errors.full_messages.to_sentence}" 
    end    
    
  rescue Exception => ex
      redirect_to asset_class_lookups_path, :alert => "Error adding entry! #{ex.message}"     
  end
  
  def destroy
    @mapping = AssetClassLookup.find(params[:id])
    @mapping.destroy
    
    redirect_to asset_class_lookups_path, :notice => 'Lookup entry deleted'
  end
  
private
  def asset_class_params
    params.require(:asset_class_lookup).permit(:security_type, :asset_class)
  end
end
