class Admin::CustomizationChoicesController < ApplicationController
    before_action :set_entry, only: [:update, :destroy]

    def set_entry
        @entry = CustomizationChoice.find(params[:id])
    end

    def customization_choice_params
        params.permit(:name, :description, :extra_cost, :manufacturer_id, :model_ref)
    end

    # GET /admin/categories/:product_type_id/options/:customization_type_id/choices
    def index
        entries = CustomizationChoice
            .where(customization_type_id: params[:customization_type_id])
        json_response(entries)
    end

    # POST /admin/categories/:product_type_id/options/:customization_type_id/choices
    def create
        names = CustomizationChoice.all.select(:name)
        prev_names = names.select { |entry| entry.name.starts_with?('choice_') }
        prev_names_indexes = prev_names.map { |entry| entry.name['choice_'.length, entry.name.length].to_i }

        new_index = 0
        new_index = prev_names_indexes.max() + 1 unless prev_names_indexes.length == 0
        new_name = 'choice_' + new_index.to_s

        new_entry = CustomizationChoice.create(
            name: new_name,
            model_ref: new_name + '_ref',
            description: 'automatically created',
            manufacturer_id: 1,
            customization_type_id: params[:customization_type_id]
        )
        json_response(new_entry)
    end

    # PUT /admin/categories/:product_type_id/options/:customization_type_id/choices/:id
    def update
        @entry.update(customization_choice_params)
        json_response({:ok => true, :choice => @entry})
    end

    # DELETE /admin/categories/:product_type_id/options/:customization_type_id/choices/:id
    def destroy
        @entry.destroy
        json_response({:ok => true, :choice => @entry})
    end
end
