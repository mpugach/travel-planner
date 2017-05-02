require 'acceptance_helper'

resource 'Trip show' do
  include_context :api
  include_context :auth

  def expect_unauthorized
    expect(status).to eq(401)
    expect(parsed_response[:errors]).to be_present
  end

  def expect_authorized(id)
    expect(status).to eq(200)
    expect(parsed_response[:errors]).to be_blank
    expect(parsed_response.dig(:data, :id)).to eq(id.to_s)
  end

  get '/api/v1/trips/:id' do
    let(:trip) { create :trip }
    let(:own_trip) { create :trip, user: current_user }

    context 'not authenticated' do
      let(:auth_headers) { {} }

      example_request 'Get non existing trip when is not authenticated', id: 0 do
        expect_unauthorized
      end

      example 'Get existing trip when is not authenticated' do
        do_request id: trip.id

        expect_unauthorized
      end
    end

    context 'authenticated' do
      header 'access-token', :access_token

      example_request 'Get non existing trip when is authenticated', id: 0 do
        expect_unauthorized
      end

      example 'Get own trip when is authenticated' do
        do_request id: own_trip.id

        expect_authorized(own_trip.id)
      end

      example 'Get other trip when is Regular user' do
        do_request id: trip.id

        expect_unauthorized
      end

      example 'Get other trip when is Manager user' do
        current_user.manager!

        do_request id: trip.id

        expect_unauthorized
      end

      example 'Get other trip when is Admin user' do
        current_user.admin!

        do_request id: trip.id

        expect_authorized(trip.id)
      end
    end
  end
end
