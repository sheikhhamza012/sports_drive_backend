class GroupPolicy < ApplicationPolicy
    attr_reader :user, :group

  def initialize(user, group)
    @user = user
    @group = group
  end
  def show? 
     !user.vendor_detail.nil? &&  user.vendor_detail.request_status=="approved" && group.arena.user_id==user.id
  end
  def create?
    group.arena.user_id==user.id && !user.vendor_detail.nil? &&  user.vendor_detail.request_status=="approved"
  end
  def update?
    !user.vendor_detail.nil? &&   user.vendor_detail.request_status=="approved" && group.arena.user_id==user.id 
  end

  
  

end