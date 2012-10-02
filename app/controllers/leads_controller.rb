class LeadsController < ApplicationController
  def create
    @lead = Lead.find_or_create_by_email(email: params[:lead][:email])
    @lead.attributes = params[:lead]
    
    if @lead.save
      redirect_to action: :unities, controller: :home, id: @lead
    else
      render "home/index"
    end
  end
end