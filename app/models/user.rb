class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  default_scope { order(:email) } 

  
  has_many :rates
  #audited
  audited only: [:email, :admin]
  audited associated_with: :rate
end
