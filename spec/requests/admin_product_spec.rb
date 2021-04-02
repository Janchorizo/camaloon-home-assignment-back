require 'rails_helper'

RSpec.describe 'Admin products API', type: :request do
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
  let(:product_id) { products.first.id }

  describe 'GET /admin/categories/id/products' do
    before { get "/admin/categories/#{category_id}/products" }

    it 'returns the products' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(200)
    end

    it 'returns all products' do
        expect(json.size).to eq(3)
      expect(json['products'].length).to eq(products.length + hidden_products.length)
    end
  end

  describe 'POST /admin/categories/id/products' do
    before { post "/admin/categories/#{category_id}/products" }

    it 'returns categories' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(200)
    end
  end

  describe 'PUT /admin/categories/id/products/id' do
    let(:valid_attributes) { {name: 'Bike 2'} }

    context 'when product exists with valid parameters' do
      before { put "/admin/categories/#{category_id}/products/#{product_id}", params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the product' do
        expect(json['product']['name']).to eq('Bike 2')
      end
    end

    context 'when product exists with invalid parameters' do
      before { put "/admin/categories//#{category_id}/products/#{product_id}", params: {:hat => true} }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when product does not exist' do
      let(:product_id) { 0 }
      before { put "/admin/categories/#{category_id}/products/#{product_id}", params: valid_attributes }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /admin/categories/id/products/id' do
    before { delete "/admin/categories/#{category_id}/products/#{product_id}" }

    context 'when product exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when product does not exist' do
      let(:product_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
