require 'acceptance_helper'

resource 'User update' do
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

  patch '/api/v1/users/me' do
    context 'not authenticated' do
      let(:auth_headers) { {} }

      example 'Update current user if not authenticated and non existing email' do
        do_request data: user_data

        expect_unauthorized
      end

      context 'existing email' do
        let(:email) { create(:user).email }

        example 'Update current user if not authenticated and existing email' do
          do_request data: user_data

          expect_unauthorized
        end
      end
    end

    context 'authenticated' do
      header 'access-token', :access_token

      context 'existing email' do
        let(:email) { create(:user).email }

        example 'Update current user if authenticated and existing email' do
          do_request data: user_data

          expect(status).to eq 422
          expect(parsed_response[:errors].first[:source][:parameter]).to eq('email')
        end
      end

      example 'Update current user if authenticated and not existing email' do
        do_request data: user_data

        expect_authorized
      end
    end
  end

  patch '/api/v1/users/:id' do
    let(:user) { create :user, email: 'test_107@example.com', role: user_role }
    let(:user_role) { 'regular' }

    context 'not authenticated' do
      let(:auth_headers) { {} }

      example 'Not authenticated, non existing email' do
        do_request id: user.id, data: user_data

        expect_unauthorized
      end

      context 'existing email' do
        let(:email) { create(:user).email }

        example 'Not authenticated, existing email' do
          do_request id: user.id, data: user_data

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

          do_request id: user.id, data: user_data

          expect(status).to eq 422
          expect(parsed_response[:errors].first[:source][:parameter]).to eq('email')
        end
      end

      User.roles.each do |to_role, to_key|
        User.roles.each do |from_role, from_key|
          context "from #{from_role} to #{to_role}" do
            let(:role) { to_role }
            let(:user_role) { from_role }

            example "Update #{from_role} user to #{to_role} as an Admin" do
              current_user.admin!

              do_request id: user.id, data: user_data

              expect_authorized
            end

            example "Update #{from_role} user to #{to_role} as a Manager" do
              current_user.manager!

              do_request id: user.id, data: user_data

              [from_role, to_role].include?('admin') ? expect_unauthorized : expect_authorized
            end

            example "Update #{from_role} user to #{to_role} as a Regular" do
              do_request id: user.id, data: user_data

              expect_unauthorized
            end
          end
        end
      end
    end
  end
end
