require 'acceptance_helper'

resource 'Sign In' do
  include_context :api

  let(:user) { create :user }

  post '/api/v1/auth/sign_in' do
    with_options required: true do
      parameter :email, 'Email'
      parameter :password, 'Password'
    end

    example 'Valid sign in' do
      do_request email: user.email, password: user.password

      expect(status).to eq(200)
      expect(parsed_response.dig(:data, :id)).to be_present
      expect(parsed_response.dig(:data, :id)).to eq(user.id)
      expect(parsed_response.dig(:data, :email)).to be_present
      expect(parsed_response.dig(:data, :email)).to eq(user.email)
    end

    example 'Wrong email' do
      do_request email: 'ololo@example.co', password: user.password

      expect(status).to eq(401)
      expect(parsed_response[:errors]).to be_present
    end

    example 'Wrong password' do
      do_request email: user.email, password: 'ololo'

      expect(status).to eq(401)
      expect(parsed_response[:errors]).to be_present
    end
  end
end
