class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role == 'manager'
      can :manage, :all
    elsif user.role == 'unity'
      can :read, Lead
      can :read, Voucher
      # can :manage, Lead do |lead|
      #   p user.unities.map(&:id).inspect
      #   user.unities.map(&:id).include?(lead.id)
      # end
    end
  end
end
