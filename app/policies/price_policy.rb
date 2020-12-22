class PricePolicy < ApplicationPolicy
    attr_reader :user, :group

  def initialize(user, post)
    @user = user
    @group = group
  end

  def create?
    group.arena.user_id==user.id && !user.vendorDetail.nil? &&  user.vendorDetail.request_status=="approved"
  end

  
  

end