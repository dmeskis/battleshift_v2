class User < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates_presence_of :password, require: true

  has_secure_password
end
