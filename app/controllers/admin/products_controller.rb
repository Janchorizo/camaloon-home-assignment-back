class Admin::ProductsController < ApplicationController
    before_action :set_entry, only: [:show, :update, :destroy]

    def set_entry
        @entry = Product.find(params[:id])
    end

    def product_params
        params.permit(:name, :description, :base_price, :hidden)
    end

    # GET /admin/categories/:product_type_id/products
    def index
        entries = Product.where(product_type_id: params[:product_type_id])
        json_response({status: 'OK', status_code: 200, products: entries})
    end

    # GET /admin/categories/:product_type_id/products/:product_id
    def show
        json_response({status: 'OK', status_code: 200, product: @entry})
    end

    # POST /admin/categories/:product_type_id/products
    def create
        names = Product.all.select(:name)
        prev_names = names.select { |entry| entry.name.starts_with?('product_') }
        prev_names_indexes = prev_names.map { |entry| entry.name['product_'.length, entry.name.length].to_i }

        new_index = 0
        new_index = prev_names_indexes.max() + 1 unless prev_names_indexes.length == 0
        new_name = 'product_' + new_index.to_s

        new_entry = Product.create(
            name: new_name,
            description: 'automatically created',
            product_type_id: params[:product_type_id]
        )

        entries = Product.where(product_type_id: params[:product_type_id])
        json_response({status: 'OK', status_code: 200, products: entries})
    end

    # PUT /admin/categories/:product_type_id/products:id
    def update
        @entry.update(product_params)
        json_response({status: 'OK', status_code: 200, product: @entry})
    end

    # DELETE /admin/categories/:categorie/products/:id
    def destroy
        @entry.destroy
        entries = Product.where(product_type_id: params[:product_type_id])
        json_response({status: 'OK', status_code: 200, products: entries})
    end
end
