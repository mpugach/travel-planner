require 'rails_helper'

describe User do
  it { should validate_presence_of(:email) }

  it { should validate_length_of(:password).is_at_least(8) }
  it { should validate_presence_of(:password) }
  it { should validate_confirmation_of(:password) }
end
