class Ability
  include CanCan::Ability

  def initialize(user, session)
    p 'aqui session ability'
    p session.inspect
    user ||= User.new(role: nil) # guest user (not logged in)
    if user.role == 'manager'
      can :manage, :all
    elsif user.role == 'unity'
      can :manage, Lead
      can :read, Voucher
    else
      can :manage, Voucher, lead_id: session[:lead_id]
    end
  end
end
