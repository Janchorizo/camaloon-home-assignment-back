class HealthController < ApplicationController
  # GET /health
    def index
        healthy = {:healthy => true}
        json_response(healthy)
    end
end

