require 'acceptance_helper'

resource 'User show' do
  include_context :api
  include_context :auth

  def expect_unauthorized
    expect(status).to eq 401
    expect(parsed_response[:errors]).to be_present
  end

  get '/api/v1/users/me' do
    context 'not authenticated' do
      let(:auth_headers) { {} }

      example_request 'Current user is not authenticated' do
        expect_unauthorized
      end
    end

    context 'authenticated' do
      example 'Current user is authenticated' do
        header 'access-token', :access_token

        do_request

        expect(status).to eq(200)
        expect(parsed_response[:errors]).to be_blank
        expect(parsed_response.dig(:data, :id)).to eq('me')
        expect(parsed_response.dig(:data, :links, :self)).to eq('/api/v1/users/me')
        expect(parsed_response.dig(:data, :attributes, :email)).to eq(user.email)
      end

      example 'Current user is authenticated, sends token of another user' do
        header 'access-token', create(:user).create_new_auth_token['access-token']

        do_request

        expect_unauthorized
      end

      example 'Current user is authenticated, sends fake token' do
        header 'access-token', 'asadasdas'

        do_request

        expect_unauthorized
      end
    end
  end
end
