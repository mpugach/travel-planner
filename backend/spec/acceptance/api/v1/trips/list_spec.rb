require 'acceptance_helper'

resource 'Trips list' do
  include_context :api
  include_context :auth

  def expect_unauthorized
    expect(status).to eq(401)
    expect(parsed_response[:errors]).to be_present
  end

  def expect_authorized
    expect(status).to eq(200)
    expect(parsed_response[:data].map { |u| u[:type] }.uniq).to eq(['trips'])
  end

  def exppect_can_see_only_owned
    expect(parsed_response[:data].count).to eq(1)
    expect(parsed_response[:data].first[:id].to_i).to be(own_trip.id)
  end

  let!(:trips) { create_list :trip, 2 }
  let!(:own_trip) { create :trip, user: current_user }

  get '/api/v1/trips' do
    context 'not authenticated' do
      let(:auth_headers) { {} }

      example_request 'Current user is not authenticated' do
        expect_unauthorized
      end
    end

    context 'authenticated' do
      header 'access-token', :access_token

      example_request 'Own trips as a Regular user' do
        expect_authorized
        exppect_can_see_only_owned
      end

      context 'authenticated admin' do
        before { current_user.admin! }

        example_request 'Own trips as an Admin user' do
          expect_authorized
          exppect_can_see_only_owned
        end
      end

      context 'authenticated manager' do
        before { current_user.manager! }

        example_request 'Own trips as a Manager user' do
          expect_authorized
          exppect_can_see_only_owned
        end
      end

      context "other user's trips" do
        example 'Other trips as a Regular user' do
          do_request user_id: trips.first.user_id

          expect_unauthorized
        end

        example 'Other trips as a Manager user' do
          current_user.manager!

          do_request user_id: trips.first.user_id

          expect_unauthorized
        end

        example 'Other trips as an Admin user' do
          current_user.admin!

          other_trip = trips.first

          do_request user_id: other_trip.user_id

          expect_authorized

          expect(parsed_response[:data].first[:id].to_i).to be(other_trip.id)
        end
      end

      context 'filters' do
        let!(:trip_1) { create :trip, destination: 'Odessa', comment: 'From Kiev', user: current_user }
        let!(:trip_2) { create :trip, destination: 'Odessa', comment: 'From Kherson', user: current_user }

        example 'Filter by term' do
          own_trip.update(destination: 'Kiev')

          do_request trips_term: 'kiev'

          expect_authorized

          expect(parsed_response[:data].map { |u| u[:id].to_i }.sort).to eq([own_trip.id, trip_1.id].sort)
        end

        example 'Filter by start_date' do
          own_trip.update(start_date: Date.tomorrow)

          do_request min_start_date: Date.current

          expect_authorized
          exppect_can_see_only_owned
        end

        example 'Filter by end_date' do
          own_trip.update(end_date: Date.yesterday)

          do_request max_end_date: Date.current

          expect_authorized
          exppect_can_see_only_owned
        end
      end
    end
  end
end
