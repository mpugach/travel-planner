require 'acceptance_helper'

resource 'Trip destroy' do
  include_context :api
  include_context :auth

  def expect_unauthorized
    expect(status).to eq 401
    expect(parsed_response[:errors]).to be_present
  end

  def expect_authorized
    expect(status).to eq(200)
    expect(parsed_response[:errors]).to be_blank
    expect(parsed_response[:data][:id].to_i).to be(trip.id)
  end

  delete '/api/v1/trips/:id' do
    let!(:trip) { create :trip }

    context 'not authenticated' do
      let(:auth_headers) { {} }

      example_request 'Delete non existing trip when is not authenticated', id: 0 do
        expect_unauthorized
      end

      example 'Delete existing trip when is not authenticated' do
        do_request id: trip.id

        expect_unauthorized
      end
    end

    context 'authenticated' do
      header 'access-token', :access_token

      example_request 'Delete non existing trip when is authenticated', id: 0 do
        expect_unauthorized
      end

      example 'Delete own trip' do
        trip.update(user: current_user)

        expect { do_request id: trip.id }.to change { Trip.count }.by(-1)

        expect_authorized
      end

      example "Delete not owned trip as an Admin" do
        current_user.admin!

        do_request id: trip.id

        expect_authorized
      end

      example "Delete not owned trip as a Manager" do
        current_user.manager!

        do_request id: trip.id

        expect_unauthorized
      end

      example "Delete not owned trip as a Regular" do
        do_request id: trip.id

        expect_unauthorized
      end
    end
  end
end
