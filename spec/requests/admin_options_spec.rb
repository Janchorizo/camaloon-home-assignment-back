require 'rails_helper'

RSpec.describe 'Admin customization options API', type: :request do
  let(:name) { 'admin' }

  # 5 not hidden categories, the first with five hidden and five visible products
  let!(:categories) {
    create_list(:product_type, 5, hidden: false)
  }
  let!(:customization_options) {
    create_list(:customization_type, 5, product_type_id: categories.first.id)
  }

  let(:category_id) { categories.first.id }
  let(:option_id) { customization_options.first.id }

  describe 'GET /admin/categories/id/options' do
    before { get "/admin/categories/#{category_id}/options" }

    it 'returns the options' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(200)
    end

    it 'returns all options' do
      expect(json.size).to eq(customization_options.length)
    end
  end

  describe 'POST /admin/categories/id/options' do
    before { post "/admin/categories/#{category_id}/options" }

    it 'returns categories' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(200)
    end
  end

  describe 'PUT /admin/categories/id/options/id' do
    let(:valid_attributes) { {name: 'Wheel color'} }

    context 'when option exists with valid parameters' do
      before { put "/admin/categories/#{category_id}/options/#{option_id}", params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the option' do
        expect(json['option']['name']).to eq('Wheel color')
      end
    end

    context 'when option exists with invalid parameters' do
      before { put "/admin/categories/#{category_id}/options/#{option_id}", params: {:hat => true} }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when option does not exist' do
      let(:option_id) { 0 }
      before { put "/admin/categories/#{category_id}/options/#{option_id}", params: valid_attributes }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /admin/categories/id/options/id' do
    before { delete "/admin/categories/#{category_id}/options/#{option_id}" }

    context 'when product exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when product does not exist' do
      let(:option_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
