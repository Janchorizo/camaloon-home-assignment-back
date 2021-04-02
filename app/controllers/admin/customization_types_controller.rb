class Admin::CustomizationTypesController < ApplicationController
    before_action :set_entry, only: [:update, :destroy]

    def set_entry
        @entry = CustomizationType.find(params[:id])
    end

    def customization_type_params
        params.permit(:name, :description)
    end

    # GET /admin/categories/:product_type_id/options
    def index
        entries = CustomizationType
            .where(product_type_id: params[:product_type_id])
        json_response({status: 'OK', status_code: 200, options: entries})
    end

    # POST /admin/categories/:product_type_id/options
    def create
        names = CustomizationType.all.select(:name)
        prev_names = names.select { |entry| entry.name.starts_with?('option_') }
        prev_names_indexes = prev_names.map { |entry| entry.name['option_'.length, entry.name.length].to_i }

        new_index = 0
        new_index = prev_names_indexes.max() + 1 unless prev_names_indexes.length == 0
        new_name = 'option_' + new_index.to_s

        new_entry = CustomizationType.create(
            name: new_name,
            description: 'automatically created',
            product_type_id: params[:product_type_id]
        )

        options = CustomizationType.where(product_type_id: params[:product_type_id])
        json_response({status: 'OK', status_code: 200, options: options})
    end

    # PUT /admin/categories/:product_type_id/options/:id
    def update
        @entry.update(customization_type_params)
        json_response({status: 'OK', status_code: 200, option: @entry})
    end

    # DELETE /admin/categories/:product_type_id/options/:id
    def destroy
        @entry.destroy
        options = CustomizationType.where(product_type_id: params[:product_type_id])
        json_response({status: 'OK', status_code: 200, options: options})
    end
end
