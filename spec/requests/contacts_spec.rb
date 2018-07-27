RSpec.describe 'contacts API', type: :request do
  # initialize test data 
  let!(:contacts) { create_list(:contact, 10) }
  let(:contact_id) { contacts.first.id }

  # Test suite for GET /contacts
  describe 'GET /contacts' do
    # make HTTP get request before each example
    before { get '/contacts' }

    it 'returns contacts' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /contacts/:id
  describe 'GET /contacts/:id' do
    before { get "/contacts/#{contact_id}" }

    context 'when the record exists' do
      it 'returns the contact' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(contact_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:contact_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

    end
  end

  # Test suite for POST /contacts
  describe 'POST /contacts' do
    # valid payload
    # let(:valid_attributes) { { email: 'CEO', created_by: '1' } }
    let(:valid_attributes) { { email: 'joe@gmail.com', name: 'Mary Smith', title: 'Don Smith',created_by: '1' } }

    context 'when the request is valid' do
      before { post '/contacts', params: valid_attributes }

      it 'creates a contact' do
        expect(json['email']).to eq('joe@gmail.com')
        expect(json['name']).to eq('Mary Smith')
        expect(json['title']).to eq('Don Smith')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/contacts', params: { name: 'Invalid' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

    end
  end

  # Test suite for PUT /contacts/:id
  describe 'PUT /contacts/:id' do
    let(:valid_attributes) { { email: 'doller@gmail.com' } }

    context 'when the record exists' do
      before { put "/contacts/#{contact_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /contacts/:id
  describe 'DELETE /contacts/:id' do
    before { delete "/contacts/#{contact_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end