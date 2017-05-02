require 'acceptance_helper'

resource 'User create' do
  include_context :api
  include_context :auth

  def expect_unauthorized
    expect(status).to eq 401
    expect(parsed_response[:errors]).to be_present
  end

  def expect_authorized
    expect(status).to eq(200)
    expect(parsed_response[:errors]).to be_blank
    expect(parsed_response[:data][:attributes][:email]).to eq(email)
  end

  post '/api/v1/users' do
    let(:role) { 'regular' }
    let(:email) { 'test_108@example.com' }

    let(:user_data) do
      {
        attributes: {
          role: role,
          email: email
        }
      }
    end

    context 'not authenticated' do
      let(:auth_headers) { {} }

      example 'Not authenticated, non existing email' do
        do_request data: user_data

        expect_unauthorized
      end

      context 'existing email' do
        let(:email) { create(:user).email }

        example 'Not authenticated, existing email' do
          do_request data: user_data

          expect_unauthorized
        end
      end
    end

    context 'authenticated' do
      header 'access-token', :access_token

      context 'existing email' do
        let(:email) { create(:user).email }

        example 'As an Admin user, existing email' do
          current_user.admin!

          do_request data: user_data

          expect(status).to eq 422
          expect(parsed_response[:errors].first[:source][:parameter]).to eq('email')
        end
      end

      User.roles.each do |role, key|
        context "#{role} role" do
          let(:role) { role }

          example "Create #{role} user as an Admin" do
            current_user.admin!

            do_request data: user_data

            expect_authorized
          end

          example "Create #{role} user as a Manager" do
            current_user.manager!

            do_request data: user_data

            role == 'admin' ? expect_unauthorized : expect_authorized
          end

          example "Create #{role} user as a Regular" do
            do_request data: user_data

            expect_unauthorized
          end
        end
      end
    end
  end
end
