class ShopController < ApplicationController
    def categories
        category_entries = ProductType.where(hidden: false)
        categories = category_entries.map {
            |entry| {:name => entry.name, :id => entry.id}
        }

        response = {
            :status => 'OK',
            :status_code => 200,
            :categories => categories
        }
        json_response(response)
    end

    def category_products
        response = nil

        begin
            category = ProductType.find(params[:category_id])

            case category.hidden
            when true
                response = {:status_code => 403, :status => "That category can't be accessed"}
            when false
                product_entries = Product.where(product_type: category, hidden: false)
                products = product_entries.map {
                    |entry| {:id => entry.id}
                }
                response = {
                    :status_code => 200,
                    :status => "OK",
                    :category_id => params[:category_id],
                    :products => products
                }
            end
        rescue ActiveRecord::RecordNotFound
            response = {:status_code => 404, :status => "That category doesn't exist"}
        end

        json_response(response, response[:status_code])
    end

    def product_details
        response = nil

        begin
            product = Product.find(params[:product_id])
            category = ProductType.find(product.product_type_id)
        rescue ActiveRecord::RecordNotFound
            response = {:status_code => 404, :status => "That product doesn't exist"}
            json_response(response, response[:status_code])
            return
        end

        case category.hidden || product.hidden
        when true
            response = {:status_code => 403, :status => "That product can't be accessed"}
            json_response(response, response[:status_code])
            return
        when false
            customization = []

            begin
                c_option_ids = (ProductChoiceLine
                    .where(product_id: product.id)
                    .select(:customization_choice_id)
                    .map {|d| d.customization_choice_id})

                c_option_type_ids = (CustomizationChoice
                    .where({ id: c_option_ids})
                    .select(:customization_type_id)
                    .distinct()
                    .map {|d| d.customization_type_id})

                customization = (CustomizationType
                    .where({ id: c_option_type_ids})
                    .map {|d| {:name => d.name, :description => d.description}})
            rescue ActiveRecord::RecordNotFound
                # There is no problem with not getting
                # customization options
            end
            response = {
                :status_code => 200,
                :status => "OK",
                :product_id => product.id,
                :product => {
                    :name => product.name,
                    :description => product.description,
                    :base_price => product.base_price,
                    :customization_options => customization
                }
            }

            json_response(response, response[:status_code])
        end
    end

    def product_choices
        response = nil

        begin
            product = Product.find(params[:product_id])
            category = ProductType.find(product.product_type_id)
        rescue ActiveRecord::RecordNotFound
            response = {:status_code => 404, :status => "That product doesn't exist"}
            json_response(response, response[:status_code])
            return
        end

        if category.hidden || product.hidden
            response = {:status_code => 403, :status => "That product can't be accessed"}
            json_response(response, response[:status_code])
            return
        end

        begin
            choices = CustomizationChoice
                .joins(:product_choice_line, :customization_type)
                .where(
                    product_choice_lines: {product_id: product.id},
                    customization_types: {name: params[:option_name]}
                ).map { |d| {
                    :name => d.name,
                    :description => d.description,
                    :supplier => d.manufacturer_id,
                    :extra_cost => d.extra_cost,
                    :stock => d.stock
                }}
        rescue ActiveRecord::RecordNotFound
            response = {:status_code => 404, :status => "That option is not available"}
            json_response(response, response[:status_code])
            return
        end

        if choices.length == 0
            response = {:status_code => 404, :status => "That option is not available"}
            json_response(response, response[:status_code])
        else
            response = {
                :status_code => 200,
                :status => "OK",
                :product_id => product.id,
                :customization_option => params[:option_name],
                :choices => choices
            }
            json_response(response, response[:status_code])
        end
    end
end
