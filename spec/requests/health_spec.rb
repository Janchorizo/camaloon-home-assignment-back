require 'rails_helper'

RSpec.describe 'Health API', type: :request do
  let(:name) { 'healthy' }
  describe 'GET /health' do
    before { get '/health' }

    it 'returns health' do
      expect(json).not_to be_empty
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
    it 'has {healthy: bool} shape' do
      expect(json.length).to eq(1)
      expect(json.keys).to contain_exactly('healthy')
    end
    it 'is healthy' do
      expect(json['healthy']).to be true
    end
  end
end

