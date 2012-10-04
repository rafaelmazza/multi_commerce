class LeadsController < ApplicationController
  def create
    # params[:lead][:latitude] = -23.605556
    # params[:lead][:longitude] = -46.665833
    
    @lead = Lead.find_or_create_by_email(email: params[:lead][:email])
    @lead.attributes = params[:lead]
    
    if @lead.save
      redirect_to action: :unities, controller: :home, id: @lead
    else
      render "home/index"
    end
  end
end