require 'acceptance_helper'

resource 'User show' do
  include_context :api
  include_context :auth

  def expect_unauthorized
    expect(status).to eq 401
    expect(parsed_response[:errors]).to be_present
  end

  def expect_authorized(id, email)
    expect(status).to eq(200)
    expect(parsed_response[:errors]).to be_blank
    expect(parsed_response.dig(:data, :id)).to eq(id.to_s)
    expect(parsed_response.dig(:data, :links, :self)).to eq(api_v1_user_path(id))
    expect(parsed_response.dig(:data, :attributes, :email)).to eq(email)
  end

  get '/api/v1/users/me' do
    context 'not authenticated' do
      let(:auth_headers) { {} }

      example_request 'Get current user when is not authenticated' do
        expect_unauthorized
      end
    end

    context 'authenticated' do
      example 'Get current user when is authenticated' do
        header 'access-token', :access_token

        do_request

        expect_authorized('me', current_user.email)
      end

      example 'Get current user when is authenticated and sending token of another user' do
        header 'access-token', create(:user).create_new_auth_token['access-token']

        do_request

        expect_unauthorized
      end

      example 'Get current user when is authenticated and sending fake token' do
        header 'access-token', 'asadasdas'

        do_request

        expect_unauthorized
      end
    end
  end

  get '/api/v1/users/:id' do
    let(:user) { create :user }

    context 'not authenticated' do
      let(:auth_headers) { {} }

      example_request 'Get non existing user when is not authenticated', id: 0 do
        expect_unauthorized
      end

      example 'Get existing user when is not authenticated' do
        do_request id: user.id

        expect_unauthorized
      end
    end

    context 'authenticated' do
      header 'access-token', :access_token

      example_request 'Get non existing user when is authenticated', id: 0 do
        expect_unauthorized
      end

      example 'Get Regular user when is Regular' do
        do_request id: user.id

        expect_unauthorized
      end

      example 'Get self' do
        do_request id: current_user.id

        expect_authorized(current_user.id, current_user.email)
      end

      example 'Get Regular user when is Manager' do
        current_user.manager!

        do_request id: user.id

        expect_authorized(user.id, user.email)
      end

      example 'Get Regular user when is Admin' do
        current_user.admin!

        do_request id: user.id

        expect_authorized(user.id, user.email)
      end
    end
  end
end
