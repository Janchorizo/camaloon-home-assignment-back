require 'rails_helper'

RSpec.describe 'Admin product choice line API', type: :request do
  let(:name) { 'admin' }

  let!(:categories) {
    create_list(:product_type, 1, hidden: false)
  }
  let!(:products) {
    create_list(:product, 1, product_type_id: categories.first.id, hidden: false)
  }
  let!(:customization_types) {
    create_list(:customization_type, 3, product_type_id: categories.first.id)
  }
  let!(:customization_choices) {
    [
      create(:customization_choice, extra_cost: 0, customization_type: customization_types[0]),
      create(:customization_choice, extra_cost: 0, customization_type: customization_types[0]),
      create(:customization_choice, extra_cost: 0, customization_type: customization_types[1]),
      create(:customization_choice, extra_cost: 0, customization_type: customization_types[2]),
    ]
  }
  let!(:product_choice_lines) {
    [
      create(:product_choice_line, product_id: products.first.id, customization_choice: customization_choices[0]),
      create(:product_choice_line, product_id: products.first.id, customization_choice: customization_choices[1]),
      create(:product_choice_line, product_id: products.first.id, customization_choice: customization_choices[2])
    ]
  }

  let(:category_id) { categories.first.id }
  let(:product_id) { products.first.id }
  let(:choice_line_id) { product_choice_lines.first.id }

  describe 'GET /admin/categories/:id/products/:id/choices' do
    before { get "/admin/categories/#{category_id}/products/#{product_id}/choices" }

    it 'returns a reponse' do
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(200)
    end

    it 'returns all product choice lines' do
      expect(json.size).to eq(product_choice_lines.length)
    end
  end

  describe 'POST /admin/categories/:id/products/:id/choices' do
    let(:valid_params) { {customization_choice_id: customization_choices.last.id} }
    before { post "/admin/categories/#{category_id}/products/#{product_id}/choices", params: valid_params }

    context 'with valid product and params' do
        it 'returns a reponse' do
            expect(json).not_to be_empty
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end

        it 'creates a new product choice line' do
            choice_lines_count = ProductChoiceLine.all.length
            expect(choice_lines_count).to eq(4)
        end
    end

    context 'with repeated product and params' do
        before { post "/admin/categories/#{category_id}/products/#{product_id}/choices", params: valid_params }
        it 'returns a reponse' do
            expect(json).not_to be_empty
        end

        it 'returns status code 422' do
            expect(response).to have_http_status(422)
        end

        it 'does not create a new product choice line' do
            choice_lines_count = ProductChoiceLine.all.length
            expect(choice_lines_count).to eq(4)
        end
    end

    context 'with valid product and missing params' do
        let(:valid_params) { }

        it 'returns a reponse' do
            expect(json).not_to be_empty
        end

        it 'returns status code 422' do
            expect(response).to have_http_status(422)
        end

        it 'does not create a new product choice line' do
            choice_lines_count = ProductChoiceLine.all.length
            expect(choice_lines_count).to eq(3)
        end
    end

    context 'with valid product and invalid params' do
        let(:valid_params) { {customization_choice_id: 0} }

        it 'returns a reponse' do
            expect(json).not_to be_empty
        end

        it 'returns status code 422' do
            expect(response).to have_http_status(422)
        end

        it 'does not create a new product choice line' do
            choice_lines_count = ProductChoiceLine.all.length
            expect(choice_lines_count).to eq(3)
        end
    end

    context 'with invalid product' do
        let(:product_id) { 0 }

        it 'returns a reponse' do
            expect(json).not_to be_empty
        end

        it 'returns status code 422' do
            expect(response).to have_http_status(422)
        end

        it 'does not create a new product choice line' do
            choice_lines_count = ProductChoiceLine.all.length
            expect(choice_lines_count).to eq(3)
        end
    end
  end

  describe 'DELETE /admin/categories' do
    before { delete "/admin/categories/#{category_id}/products/#{product_id}/choices/#{choice_line_id}" }

    context 'when choice line exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'deleted the choice line' do
        choice_lines_count = ProductChoiceLine.all.length
        expect(choice_lines_count).to eq(2)
      end
    end

    context 'when choice line does not exist' do
      let(:choice_line_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
