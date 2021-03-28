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
end
