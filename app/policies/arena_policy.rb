class ArenaPolicy < ApplicationPolicy
    attr_reader :user, :arena

  def initialize(user, arena)
    @user = user
    @arena = arena
  end

  def create?
    user.isVendor 
  end

  def update?
    arena.user == user 
  end

  def delete?
    user.isVendor
  end
  
  def book_arena?
    !user.isVendor 
  end
  def show?
    true 
  end
  def availibility?
    true 
  end
  

end