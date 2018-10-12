class User < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates_presence_of :password, require: true
  validates_presence_of :email
  enum status: %w(unactivated activated)

  has_secure_password
end
