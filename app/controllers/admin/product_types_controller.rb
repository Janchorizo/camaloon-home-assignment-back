class Admin::ProductTypesController < ApplicationController
    before_action :set_entry, only: [:update, :destroy]

    def set_entry
        @entry = ProductType.find(params[:id])
    end

    def product_type_params
        params.permit(:name, :description, :hidden)
    end

    # GET /admin/categories
    def index
        entries = ProductType.all
        json_response({status: 'OK', status_code: 200, categories: entries})
    end

    # POST /admin/categories
    def create
        names = ProductType.all.select(:name)
        prev_names = names.select { |entry| entry.name.starts_with?('category_') }
        prev_names_indexes = prev_names.map { |entry| entry.name['category_'.length, entry.name.length].to_i }

        new_index = 0
        new_index = prev_names_indexes.max() + 1 unless prev_names_indexes.length == 0
        new_name = 'category_' + new_index.to_s

        new_entry = ProductType.create(name: new_name, description: 'automatically created')

        json_response({status: 'OK', status_code: 200, categories: ProductType.all})
    end

    # PUT /admin/categories/:id
    def update
        @entry.update(product_type_params)
        json_response({status: 'OK', status_code: 200, category: @entry})
    end

    # DELETE /admin/categories/:id
    def destroy
        @entry.destroy
        json_response({status: 'OK', status_code: 200, categories: ProductType.all})
    end
end
