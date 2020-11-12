class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :first_name, presence: true
  validates :city, presence: true
  validates :last_name, presence: true
  validates :password, length: { in: 6..20 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } , uniqueness: true
  validates :phone,  length: { minimum: 11,maximum: 12 }, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
