class LeadsController < ApplicationController
  layout "home"
  
  def create
    @lead = Lead.find_or_create_by_email(email: params[:lead][:email])
    @lead.attributes = params[:lead]
    
    if @lead.save
      session[:lead_id] = @lead.id
      redirect_to action: :unities, controller: :home
    else
      render "home/index"
    end
  end
  
  def update
    @lead = Lead.find(session[:lead_id])
    @lead.update_attributes params[:lead]
    
    if @lead.save
      redirect_to action: :unities, controller: :home
    else
      render "home/index"
    end
  end
end