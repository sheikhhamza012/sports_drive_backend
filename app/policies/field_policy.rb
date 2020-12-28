class FieldPolicy < ApplicationPolicy
    attr_reader :user, :field

  def initialize(user, field)
    @user = user
    @field = field
  end
  def book_arena? 
    true
  end

  
  

end