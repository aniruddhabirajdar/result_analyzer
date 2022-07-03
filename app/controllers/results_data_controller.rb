class ResultsDataController < ApplicationController
    wrap_parameters :result, include: [:subject, :timestamp, :marks]
    
    # POST /comments
    def create
        @result_data=ResultData.new(result_params)
        if @result_data.save
        render json: @result_data.to_json(), status: :created
        else
        render json: @result_data.errors, status: :unprocessable_entity
        end
    end

    private
    def result_params
        params.require(:result).permit(:subject, :timestamp, :marks)
    end
end
