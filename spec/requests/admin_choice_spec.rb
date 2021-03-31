require 'rails_helper'

RSpec.describe 'Admin customization choices API', type: :request do
  let(:name) { 'admin' }

  let!(:categories) {
    create_list(:product_type, 1, hidden: false)
  }
  let!(:customization_types) {
    create_list(:customization_type, 3, product_type_id: categories.first.id)
  }
  let!(:customization_choices) {
    [
      create(:customization_choice, extra_cost: 0, customization_type: customization_types[0]),
      create(:customization_choice, extra_cost: 0, customization_type: customization_types[0]),
      create(:customization_choice, extra_cost: 0, customization_type: customization_types[2])
    ]
  }

  let(:category_id) { categories.first.id }
  let(:option_id) {customization_types.first.id}
  let(:choice_id) {customization_choices.first.id}

  describe 'GET /admin/categories' do
    before { get "/admin/categories/#{category_id}/options/#{option_id}/choices" }

    it 'returns categories' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(200)
    end

    it 'returns all category categories' do
      expect(json.size).to eq(2)
    end
  end

  describe 'POST /admin/categories' do
    before { post "/admin/categories/#{category_id}/options/#{option_id}/choices" }

    it 'returns categories' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(200)
    end
  end

  describe 'PUT /admin/categories/:id/options/:id/choices/:id' do
    let(:valid_attributes) { {name: 'Hardware choice 2'} }

    context 'when choice exists with valid parameters' do
      before { put "/admin/categories/#{category_id}/options/#{option_id}/choices/#{choice_id}", params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns an update customization option' do
        expect(json['choice']['name']).to eq('Hardware choice 2')
      end
    end

    context 'when choice exists with invalid parameters' do
      before { put "/admin/categories/#{category_id}/options/#{option_id}/choices/#{choice_id}", params: {:hat => true} }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when choice does not exist' do
      let(:choice_id) { 0 }
      before { put "/admin/categories/#{category_id}/options/#{option_id}/choices/#{choice_id}", params: valid_attributes }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /admin/categories/:id/options/:id/choices/:id' do
    before { delete "/admin/categories/#{category_id}/options/#{option_id}/choices/#{choice_id}" }

    context 'when choice exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when choice does not exist' do
      let(:choice_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
