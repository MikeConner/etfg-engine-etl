class InstrumentTemplatesController < ApplicationController
  before_action :authenticate_user!

  def create
    @template = InstrumentTemplate.new(template_params)
    if @template.save
      # Read the file and set it
    else
      flash.now[:alert] = @template.errors.full_messages.to_sentence
      render templates_path, :layout => 'admin'
    end
  end
  
private
  def template_params
    params.require(:instrument_template).permit(:user_id, :template_file)
  end
end
