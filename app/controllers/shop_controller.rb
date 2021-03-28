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
end
