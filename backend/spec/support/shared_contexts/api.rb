shared_context :api do
  header 'Content-Type', 'application/json'

  let(:raw_post) { params.to_json }
  let(:parsed_response) { JSON.parse(response_body, symbolize_names: true) }
end
