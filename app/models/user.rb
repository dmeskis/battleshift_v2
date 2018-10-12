class User < ApplicationRecord
  before_save   :downcase_email

  validates :name, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :email
  enum status: %w(unactivated activated)

  has_secure_password

  private
    def downcase_email
      self.email = email.downcase
    end
end
