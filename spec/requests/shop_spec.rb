require 'rails_helper'

RSpec.describe 'Shop API', type: :request do
  let(:name) { 'shop' }

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

  describe 'GET /shop/categories' do
    before { get '/shop/categories' }

    it 'returns categories' do
      expect(json).not_to be_empty
    end
    it 'returns status code 200' do
        expect(response).to have_http_status(200)
    end
    it 'has {status, status_code, categories} shape' do
      expect(json.length).to eq(3)
      expect(json.keys).to contain_exactly('status', 'status_code', 'categories')
    end
    it 'has categories with {name, id} shape' do
      for category in json['categories'] do
        expect(category.length).to eq(2)
        expect(category.keys).to contain_exactly('name', 'id')
      end
    end
    it 'does not return hidden categories types' do
      create(:product_type, hidden: true)
      expect(json['categories'].length).to eq(categories.length)
      for category in json['categories'] do
        expect(ProductType.find(category['id']).hidden).to eq(false)
      end
    end
  end

  describe 'GET /shop/categories/<category_id>/products' do
    before { get "/shop/categories/#{categories.first.id}/products" }

    it 'returns the products' do
      expect(json).not_to be_empty
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
    it 'has {status, status_code, category_id, products} shape' do
      expect(json.length).to eq(4)
      expect(json.keys).to contain_exactly('status', 'status_code', 'category_id', 'products')
    end
    it 'has products with {id} shape' do
      for product in json['products'] do
          expect(product.length).to eq(1)
          expect(product.keys).to contain_exactly('id')
      end
    end
    it 'does not return hidden products' do
      expect(json['products'].length).to eq(products.length)
      for product in json['products'] do
          expect(Product.find(product['id']).hidden).to eq(false)
      end
    end
  end

  describe 'GET /shop/categories/<category_id>/products for hidden category' do
    before { get "/shop/categories/#{hidden_categories.first.id}/products" }

    it 'returns the products' do
      expect(json).not_to be_empty
    end
    it 'returns status code 403' do
      expect(response).to have_http_status(403)
    end
    it 'has {status, status_code} shape' do
      expect(json.length).to eq(2)
      expect(json.keys).to contain_exactly('status', 'status_code')
    end
  end

  describe 'GET /shop/categories/<category_id>/products for non-existing category' do
    before { get "/shop/categories/#{hidden_categories.last.id + 10}/products" }

    it 'returns the products' do
      expect(json).not_to be_empty
    end
    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end
    it 'has {status, status_code} shape' do
      expect(json.length).to eq(2)
      expect(json.keys).to contain_exactly('status', 'status_code')
    end
  end

#  describe 'GET /shop/product/<product_id>/specs' do
#    before { get '/shop/product/<product_id>/specs' }
#
#    it 'returns health' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 200' do
#      expect(response).to have_http_status(200)
#    end
#    it 'has {healthy: bool} shape' do
#      expect(json.length).to eq(1)
#      expect(json.keys).to contain_exactly('healthy')
#    end
#    it 'is healthy' do
#      expect(json['healthy']).to be true
#    end
#  end
#
#  describe 'GET /shop/product/<product_id>/factory_model' do
#    before { get '/shop/product/<product_id>/factory_model' }
#
#    it 'returns health' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 200' do
#      expect(response).to have_http_status(200)
#    end
#    it 'has {healthy: bool} shape' do
#      expect(json.length).to eq(1)
#      expect(json.keys).to contain_exactly('healthy')
#    end
#    it 'is healthy' do
#      expect(json['healthy']).to be true
#    end
#  end
#
#  describe 'GET shop/product/<product_id>/option/<customization_option_name>/choices' do
#    before { get 'shop/product/<product_id>/option/<customization_option_name>/choices' }
#
#    it 'returns health' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 200' do
#      expect(response).to have_http_status(200)
#    end
#    it 'has {healthy: bool} shape' do
#      expect(json.length).to eq(1)
#      expect(json.keys).to contain_exactly('healthy')
#    end
#    it 'is healthy' do
#      expect(json['healthy']).to be true
#    end
#  end
end
