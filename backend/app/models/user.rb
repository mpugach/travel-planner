class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  include DeviseTokenAuth::Concerns::User

  enum role: %i[regular manager admin]

  validates :email, uniqueness: true

  def can_manage_users?
    manager? || admin?
  end

  def permitted_roles_to_set
    return [] if regular?

    all_roles = self.class.roles.keys

    return all_roles - %w[admin] if manager?

    all_roles
  end
end
