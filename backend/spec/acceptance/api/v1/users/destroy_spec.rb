require 'acceptance_helper'

resource 'User destroy' do
  include_context :api
  include_context :auth

  def expect_unauthorized
    expect(status).to eq 401
    expect(parsed_response[:errors]).to be_present
  end

  def expect_authorized
    expect(status).to eq(200)
    expect(parsed_response[:errors]).to be_blank
    expect(parsed_response[:data][:id].to_i).to be(user.id)
    expect(User.where(id: user.id).any?).to be_falsey
  end

  delete '/api/v1/users/:id' do
    let(:user) { create :user }

    context 'not authenticated' do
      let(:auth_headers) { {} }

      example_request 'Delete non existing user when is not authenticated', id: 0 do
        expect_unauthorized
      end

      example 'Get existing user when is not authenticated' do
        do_request id: user.id

        expect_unauthorized
      end
    end

    context 'authenticated' do
      header 'access-token', :access_token

      example_request 'Delete non existing user when is authenticated', id: 0 do
        expect_unauthorized
      end

      example 'Delete self' do
        do_request id: current_user.id

        expect_unauthorized
      end

      User.roles.each do |role, key|
        example "Delete #{role} user as an Admin" do
          current_user.admin!

          user.update(role: key)

          do_request id: user.id

          expect_authorized
        end

        example "Delete #{role} user as a Manager" do
          current_user.manager!

          user.update(role: key)

          do_request id: user.id

          role == 'admin' ? expect_unauthorized : expect_authorized
        end

        example "Delete #{role} user as a Regular" do
          user.update(role: key)

          do_request id: user.id

          expect_unauthorized
        end
      end
    end
  end
end
