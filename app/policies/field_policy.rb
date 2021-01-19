class FieldPolicy < ApplicationPolicy
    attr_reader :user, :field

    def initialize(user, field)
      @user = user
      @field = field
    end
    def update?
      @field.group.arena.user == @user
    end
  def book_arena? 
    true
  end

  
  

end