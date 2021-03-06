class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :first_name, presence: true
  validates :city, presence: true
  validates :last_name, presence: true
  validates :password,presence: true, length: { in: 6..20 },:on => :create
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } , uniqueness: true
  validates :phone,  length: { minimum: 11,maximum: 12 }, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum player_of: ["Cricket","Football","Basket Ball","Badminton","Squash","Swimming","Tennis","Table Tenis"]
  mount_uploader :image, ImageUploader

  has_one :arena, dependent: :destroy
  has_many :arena_booking_requests, dependent: :destroy
  has_many :devices, dependent: :destroy
  has_many :booked_arenas,through: :arena_booking_requests, dependent: :destroy, source: :arena
  has_one :vendor_detail
  has_one :my_team, class_name: 'Team', foreign_key: 'user_id'
  has_many :team_requests
  has_many :teams, -> {where(team_requests: {status: :accepted})}, through: :team_requests
  def get_visible_attr
    user = attributes.slice("id","first_name","last_name","email","phone","city","isVendor","about","featured","rating","player_of")
  end
  
end
