require 'rails_helper'

describe Trip do
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:destination) }
end
