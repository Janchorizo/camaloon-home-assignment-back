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

#  describe 'GET /shop/categories' do
#    before { get '/shop/categories' }
#
#    it 'returns categories' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 200' do
#        expect(response).to have_http_status(200)
#    end
#    it 'has {status, status_code, categories} shape' do
#      expect(json.length).to eq(3)
#      expect(json.keys).to contain_exactly('status', 'status_code', 'categories')
#    end
#    it 'has categories with {name, id} shape' do
#      for category in json['categories'] do
#        expect(category.length).to eq(2)
#        expect(category.keys).to contain_exactly('name', 'id')
#      end
#    end
#    it 'does not return hidden categories types' do
#      create(:product_type, hidden: true)
#      expect(json['categories'].length).to eq(categories.length)
#      for category in json['categories'] do
#        expect(ProductType.find(category['id']).hidden).to eq(false)
#      end
#    end
#  end
#
#  describe 'GET /shop/categories/<category_id>/products' do
#    before { get "/shop/categories/#{categories.first.id}/products" }
#
#    it 'returns the products' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 200' do
#      expect(response).to have_http_status(200)
#    end
#    it 'has {status, status_code, category_id, products} shape' do
#      expect(json.length).to eq(4)
#      expect(json.keys).to contain_exactly('status', 'status_code', 'category_id', 'products')
#    end
#    it 'has products with {id} shape' do
#      for product in json['products'] do
#          expect(product.length).to eq(1)
#          expect(product.keys).to contain_exactly('id')
#      end
#    end
#    it 'does not return hidden products' do
#      expect(json['products'].length).to eq(products.length)
#      for product in json['products'] do
#          expect(Product.find(product['id']).hidden).to eq(false)
#      end
#    end
#  end
#
#  describe 'GET /shop/categories/<category_id>/products for hidden category' do
#    before { get "/shop/categories/#{hidden_categories.first.id}/products" }
#
#    it 'returns the products' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 403' do
#      expect(response).to have_http_status(403)
#    end
#    it 'has {status, status_code} shape' do
#      expect(json.length).to eq(2)
#      expect(json.keys).to contain_exactly('status', 'status_code')
#    end
#  end
#
#  describe 'GET /shop/categories/<category_id>/products for non-existing category' do
#    before { get "/shop/categories/#{hidden_categories.last.id + 10}/products" }
#
#    it 'returns the products' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 404' do
#      expect(response).to have_http_status(404)
#    end
#    it 'has {status, status_code} shape' do
#      expect(json.length).to eq(2)
#      expect(json.keys).to contain_exactly('status', 'status_code')
#    end
#  end
#
#  describe 'GET /shop/products/<product_id>/specs' do
#    before { get "/shop/products/#{products.first.id}/specs" }
#
#    it 'returns the products' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 200' do
#      expect(response).to have_http_status(200)
#    end
#    it 'has {status, status_code, product_id, product} shape' do
#      expect(json.length).to eq(4)
#      expect(json.keys).to contain_exactly('status', 'status_code', 'product_id', 'product')
#    end
#    it 'has a product value with {name, description, base_price, customization_options} shape' do
#      expect(json['product'].length).to eq(4)
#      expect(json['product'].keys).to contain_exactly('name', 'description', 'base_price', 'customization_options')
#    end
#    it 'the customization options have a {name, description} shape' do
#      expect(json['product']['customization_options'].length).to eq(3)
#      for c_option in json['product']['customization_options'] do
#        expect(c_option.length).to eq(2)
#        expect(c_option.keys).to contain_exactly('name', 'description')
#      end
#    end
#  end
#
#  describe 'GET /shop/products/<product_id>/specs returns empty customization options if there aren\'t' do
#    before { get "/shop/products/#{products[1].id}/specs" }
#
#    it 'returns the products' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 200' do
#      expect(response).to have_http_status(200)
#    end
#    it 'the customization options array has zero length' do
#      expect(json['product']['customization_options'].length).to eq(0)
#    end
#  end
#
#  describe 'GET /shop/products/<product_id>/specs from a hidden category' do
#    before { get "/shop/products/#{products_in_hidden_category.first.id}/specs" }
#
#    it 'returns a response' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 403' do
#      expect(response).to have_http_status(403)
#    end
#    it 'has {status, status_code} shape' do
#      expect(json.length).to eq(2)
#      expect(json.keys).to contain_exactly('status', 'status_code')
#    end
#  end
#
#  describe 'GET /shop/products/<product_id>/specs for a hidden product' do
#    before { get "/shop/products/#{hidden_products.first.id}/specs" }
#
#    it 'returns a response' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 403' do
#      expect(response).to have_http_status(403)
#    end
#    it 'has {status, status_code} shape' do
#      expect(json.length).to eq(2)
#      expect(json.keys).to contain_exactly('status', 'status_code')
#    end
#  end
#
#  describe 'GET /shop/products/<product_id>/specs for non-existing product' do
#    before { get "/shop/products/#{products.last.id + 100}/specs" }
#
#    it 'returns a response' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 404' do
#      expect(response).to have_http_status(404)
#    end
#    it 'has {status, status_code} shape' do
#      expect(json.length).to eq(2)
#      expect(json.keys).to contain_exactly('status', 'status_code')
#    end
#  end

describe 'GET /shop/products/<product_id>/factory_model' do
  before { get "/shop/products/#{products.first.id}/factory_model" }

  it 'returns the products' do
    expect(json).not_to be_empty
  end
  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end
  it 'has {status, status_code, product_id, customization_options} shape' do
    expect(json.length).to eq(4)
    expect(json.keys).to contain_exactly('status', 'status_code', 'product_id', 'customization_options')
  end
  it 'the customization options have a {name, description, supplier, extra_cost} shape' do
    expect(json['customization_options'].length).to eq(3)
    for c_option in json['customization_options'] do
      expect(json['product'].length).to eq(4)
      expect(json['product'].keys).to contain_exactly('name', 'description', 'supplier', 'extra_cost')
    end
  end
end

describe 'GET /shop/products/<product_id>/factory_model returns empty customization options if there aren\'t' do
  before { get "/shop/products/#{products[1].id}/factory_model" }

  it 'returns the products' do
    expect(json).not_to be_empty
  end
  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end
  it 'has {status, status_code, product_id, customization_options} shape' do
    expect(json.length).to eq(4)
    expect(json.keys).to contain_exactly('status', 'status_code', 'product_id', 'customization_options')
  end
  it 'the customization options array has zero length' do
    expect(json['customization_options'].length).to eq(0)
  end
end

describe 'GET /shop/products/<product_id>/factory_model from a hidden category' do
  before { get "/shop/products/#{products_in_hidden_category.first.id}/factory_model" }

  it 'returns a response' do
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

describe 'GET /shop/products/<product_id>/factory_model for a hidden product' do
  before { get "/shop/products/#{hidden_products.first.id}/factory_model" }

  it 'returns a response' do
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

describe 'GET /shop/products/<product_id>/factory_model for non-existing product' do
  before { get "/shop/products/#{products.last.id + 100}/factory_model" }

  it 'returns a response' do
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

#  describe 'GET /shop/products/<product_id>/option/<option_name>/choices' do
#    before { get "/shop/products/#{products.first.id}/option/#{customization_types.first.name}/choices" }
#
#    it 'returns the choice' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 200' do
#      expect(response).to have_http_status(200)
#    end
#    it 'has {status, status_code, product_id, customization_option, choices} shape' do
#      expect(json.length).to eq(5)
#      expect(json.keys).to contain_exactly('status', 'status_code', 'product_id', 'customization_option', 'choices')
#    end
#    it 'the customization options have a {name, description, supplier, extra_cost, stock} shape' do
#      expect(json['choices'].length).to eq(3)
#      for c_option in json['choices'] do
#        expect(c_option.length).to eq(5)
#        expect(c_option.keys).to contain_exactly('name', 'description', 'supplier', 'extra_cost', 'stock')
#      end
#    end
#  end
#
#  describe 'GET /shop/products/<product_id>/option/<option_name>/choices for a not-available option' do
#    before { get "/shop/products/#{products.first.id}/option/#{customization_types.last.name + customization_types.last.name}/choices" }
#
#    it 'returns the products' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 404' do
#      expect(response).to have_http_status(404)
#    end
#  end
#
#  describe 'GET /shop/products/<product_id>/option/<option_name>/choices from a hidden category' do
#    before { get "/shop/products/#{products_in_hidden_category.first.id}/option/1/choices" }
#
#    it 'returns a response' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 403' do
#      expect(response).to have_http_status(403)
#    end
#    it 'has {status, status_code} shape' do
#      expect(json.length).to eq(2)
#      expect(json.keys).to contain_exactly('status', 'status_code')
#    end
#  end
#
#  describe 'GET /shop/products/<product_id>/option/<option_name>/choices for a hidden product' do
#    before { get "/shop/products/#{hidden_products.first.id}/option/1/choices" }
#
#    it 'returns a response' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 403' do
#      expect(response).to have_http_status(403)
#    end
#    it 'has {status, status_code} shape' do
#      expect(json.length).to eq(2)
#      expect(json.keys).to contain_exactly('status', 'status_code')
#    end
#  end
#
#  describe 'GET /shop/products/<product_id>/option/<option_name>/choices for non-existing product' do
#    before { get "/shop/products/#{hidden_products.first.id + 100}/option/1/choices" }
#
#    it 'returns a response' do
#      expect(json).not_to be_empty
#    end
#    it 'returns status code 404' do
#      expect(response).to have_http_status(404)
#    end
#    it 'has {status, status_code} shape' do
#      expect(json.length).to eq(2)
#      expect(json.keys).to contain_exactly('status', 'status_code')
#    end
#  end
end
