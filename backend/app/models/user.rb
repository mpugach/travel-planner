class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  include DeviseTokenAuth::Concerns::User

  enum role: %i[regular manager admin]

  validates :email, uniqueness: true

  def can_manage_users?
    manager? || admin?
  end
end
