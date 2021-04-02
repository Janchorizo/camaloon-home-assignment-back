class Admin::ProductChoiceLinesController < ApplicationController
    before_action :set_entry, only: [:destroy]

    def set_entry
        @entry = ProductChoiceLine.find(params[:id])
    end

    # GET /admin/categories/:product_type_id/products/:product_id/choices
    def index
        columns = ('product_choice_lines.id, customization_choices.name,' +
        ' customization_choices.description, customization_choices.model_ref,' +
        ' customization_choices.extra_cost, customization_types.name as type,' +
        ' customization_types.id as type_id, product_choice_lines.customization_choice_id as choice_id')
        entries = CustomizationChoice
            .joins(:product_choice_line, :customization_type)
            .where(product_choice_lines: {product_id: params[:product_id]})
            .select(columns)
        json_response({status: 'OK', status_code: 200, choices: entries})
    end

    # POST /admin/categories/:product_type_id/products/:product_id/choices
    def create
        choice_id = params.require(:customization_choice_id)

        # The product choice line already exists
        begin
            line = ProductChoiceLine.where(
                customization_choice_id: choice_id,
                product_id: params[:product_id]
            )

            if line.nil? == false && line.length > 0
                json_response({:status => 'Invalid request', :status_code => 422}, 422)
                return
            end
        rescue
        end

        choice_type = CustomizationType
            .joins(:customization_choice)
            .where(customization_choices: {id: choice_id})[0]

        product_type = ProductType
            .joins(:product)
            .where(products: {id: params[:product_id]})[0]

        # The provided foreign keys are not correct
        if choice_type.nil? || product_type.nil?
            json_response({:status => 'Invalid request', :status_code => 422}, 422)
            return
        end
        
        # It is not a valid option for that product_type
        if choice_type.product_type_id != product_type.id
            json_response({:status => 'Invalid request', :status_code => 422}, 422)
            return
        end

        new_entry = ProductChoiceLine.create(
            product_id: params[:product_id],
            customization_choice_id: choice_id
        )

        columns = ('product_choice_lines.id, customization_choices.name,' +
        ' customization_choices.description, customization_choices.model_ref,' +
        ' customization_choices.extra_cost, customization_types.name as type,' +
        ' customization_types.id as type_id, product_choice_lines.customization_choice_id as choice_id')
        entries = CustomizationChoice
            .joins(:product_choice_line, :customization_type)
            .where(product_choice_lines: {product_id: params[:product_id]})
            .select(columns)
        json_response({status: 'OK', status_code: 200, choices: entries})
    end

    # DELETE /admin/categories/:product_type_id/options/:customization_type_id/choices/:id
    def destroy
        @entry.destroy
        columns = ('product_choice_lines.id, customization_choices.name,' +
        ' customization_choices.description, customization_choices.model_ref,' +
        ' customization_choices.extra_cost, customization_types.name as type,' +
        ' customization_types.id as type_id, product_choice_lines.customization_choice_id as choice_id')
        entries = CustomizationChoice
            .joins(:product_choice_line, :customization_type)
            .where(product_choice_lines: {product_id: params[:product_id]})
            .select(columns)
        json_response({status: 'OK', status_code: 200, choices: entries})
    end
end
