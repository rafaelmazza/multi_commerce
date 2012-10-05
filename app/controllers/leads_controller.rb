class LeadsController < ApplicationController
  def create
    # params[:lead][:latitude] = -23.605556 # tmp
    # params[:lead][:longitude] = -46.665833 # tmp
    
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
    end
  end
end