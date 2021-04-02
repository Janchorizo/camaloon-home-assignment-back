require 'rails_helper'

RSpec.describe 'Admin categories API', type: :request do
  let(:name) { 'admin' }

  # 5 not hidden categories, the first with five hidden and five visible products
  let!(:categories) {
    create_list(:product_type, 5, hidden: false)
  }
  let!(:products) {
    create_list(:product, 5, product_type_id: categories.first.id, hidden: false)
  }
  let!(:hidden_products) {
    create_list(:product, 5, product_type_id: categories.first.id, hidden: true)
  }
  let!(:customization_types) {
    create_list(:customization_type, 3, product_type_id: categories.first.id)
  }
  let!(:customization_choices) {
    [
      create(:customization_choice, extra_cost: 0, customization_type: customization_types[0]),
      create(:customization_choice, extra_cost: 0, customization_type: customization_types[1]),
      create(:customization_choice, extra_cost: 0, customization_type: customization_types[2])
    ]
  }
  let!(:product_choice_lines) {
    [
      create(:product_choice_line, product: products[0], customization_choice: customization_choices[0]),
      create(:product_choice_line, product: products[0], customization_choice: customization_choices[0]),
      create(:product_choice_line, product: products[0], customization_choice: customization_choices[0]),
      create(:product_choice_line, product: products[0], customization_choice: customization_choices[1]),
      create(:product_choice_line, product: products[0], customization_choice: customization_choices[2])
    ]
  }

  # 5 hidden categories, the first with five hidden and five visible products
  let!(:hidden_categories) {
    create_list(:product_type, 5, hidden: true)
  }
  let!(:products_in_hidden_category) {
    create_list(:product, 5, product_type_id: hidden_categories.first.id, hidden: false)
  }
  let!(:hidden_products_in_hidden_category) {
    create_list(:product, 5, product_type_id: hidden_categories.first.id, hidden: true)
  }

  let(:category_id) { categories.first.id }

  describe 'GET /admin/categories' do
    before { get '/admin/categories' }

    it 'returns categories' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(200)
    end

    it 'returns all category categories' do
      expect(json.size).to eq(3)
      expect(json['categories'].length).to eq(categories.length + hidden_categories.length)
    end
  end

  describe 'POST /admin/categories' do
    before { post '/admin/categories' }

    it 'returns categories' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(200)
    end
  end

  describe 'PUT /admin/categories' do
    let(:valid_attributes) { {name: 'Hardware'} }

    context 'when category exists with valid parameters' do
      before { put "/admin/categories/#{category_id}", params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when category exists with invalid parameters' do
      before { put "/admin/categories/#{category_id}", params: {:hat => true} }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns an unchanged category' do
        expect(json['category']['name']).to eq(categories.first.name)
        expect(json['category']['description']).to eq(categories.first.description)
      end
    end

    context 'when category does not exist' do
      let(:category_id) { 0 }
      before { put "/admin/categories/#{category_id}", params: valid_attributes }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /admin/categories' do
    before { delete "/admin/categories/#{category_id}" }

    context 'when category exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when category does not exist' do
      let(:category_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
