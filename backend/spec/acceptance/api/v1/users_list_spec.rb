require 'acceptance_helper'

resource 'Users list' do
  include_context :api
  include_context :auth

  def expect_unauthorized
    expect(status).to eq 401
    expect(parsed_response[:errors]).to be_present
  end

  def expect_authorized
    expect(status).to eq(200)
    expect(parsed_response[:data].count).to be(3)
    expect(parsed_response[:data].map { |u| u[:type] }.uniq).to eq(['users'])
  end

  before { create_list :user, 2 }

  get '/api/v1/users' do
    context 'not authenticated' do
      let(:auth_headers) { {} }

      example_request 'Current user is not authenticated' do
        expect_unauthorized
      end
    end

    context 'authenticated regular' do
      example_request 'Regular user' do
        expect_unauthorized
      end
    end

    context 'authenticated admin' do
      before { current_user.admin! }

      example_request 'Admin user' do
        expect_authorized
      end
    end

    context 'authenticated manager' do
      before { current_user.manager! }

      example_request 'Manager user' do
        expect_authorized
      end
    end
  end
end
