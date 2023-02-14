# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    can :read, Reservation
    can :read, RealEstate 
    can :read, City

    return unless user

    # guest
    can :create, Reservation
    can :destroy, Reservation, guest_id: user.id
    can :read, Reservation, guest_id: user.id

    # host
    can :manage, RealEstate, host_id: user.id
    can :manage, Reservation, real_estate: { host_id: user.id }
    can :manage, Day, real_estate: { host_id: user.id }
  end
end
