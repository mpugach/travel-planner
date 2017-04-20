class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  include DeviseTokenAuth::Concerns::User
end
