shared_context :auth do
  header 'uid', :uid
  header 'client', :client_header
  header 'expiry', :expiry
  header 'token-type', :token_type
  header 'access-token', :access_token

  let(:user) { create :user }

  let(:auth_headers) { user.create_new_auth_token }

  let(:uid) { auth_headers['uid'] }
  let(:expiry) { auth_headers['expiry'] }
  let(:token_type) { auth_headers['token-type'] }
  let(:access_token) { auth_headers['access-token'] }
  let(:client_header) { auth_headers['client'] }
end
