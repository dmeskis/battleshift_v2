class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest

  validates :name, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :email
  enum status: %w(unactivated activated)

  has_secure_password

  private
    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
