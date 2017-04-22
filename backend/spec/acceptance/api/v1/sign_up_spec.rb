require 'acceptance_helper'

resource 'Sign Up' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  let(:raw_post) { params.to_json }
  let(:parsed_response) { JSON.parse(response_body, symbolize_names: true) }

  email = 'test@example.com'
  password = 'password'

  def expect_wrong_field(field, user_count=0)
    expect(status).to eq 422
    expect(User.count).to be(user_count)
    expect(parsed_response[:status]).to eq('error')
    expect(parsed_response.dig(:errors, field)).to be_present
  end

  post '/api/v1/auth' do
    with_options required: true do
      parameter :email, 'Email'
      parameter :password, 'Password'
    end

    example_request 'Valid registration', email: email, password: password do
      user = User.find_by(email: email)

      expect(status).to eq(200)
      expect(parsed_response[:errors]).to be_blank
      expect(parsed_response[:status]).to eq('success')
      expect(parsed_response.dig(:data, :id)).to eq(user.id)
      expect(parsed_response.dig(:data, :email)).to eq(user.email)
    end

    example_request 'No email', password: password do
      expect_wrong_field :email
    end

    example_request 'Wrong email format', email: 'ololo', password: password do
      expect_wrong_field :email
    end

    example_request 'No password', email: email do
      expect_wrong_field :password
    end

    example_request 'Password too short', password: 'pass', email: email do
      expect_wrong_field :password
    end

    example 'Email is taken' do
      create :user, email: email
      do_request email: email, password: password
      expect_wrong_field :email, 1
    end
  end
end
