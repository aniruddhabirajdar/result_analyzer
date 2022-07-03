require 'rails_helper'

RSpec.describe "ResultsData", type: :request do
  describe "GET /results_data" do
    context "with valid parameters" do
      let!(:post_request) do  
        post "/results_data", params: {
                                result: {
                                  subject: "Science",
                                  timestamp: "2022-04-18 12:02:44.678",
                                  marks: 123.26
                                 } }
      end

        it "create result data" do
          post_request
          expect(response).to be_successful
          expect(JSON.parse(response.body)["subject"]).to eq("Science")
          expect(JSON.parse(response.body)["timestamp"].to_time).to eq("2022-04-18 12:02:44.678z".to_time)
          expect(JSON.parse(response.body)["marks"]).to eq("123.26")
        end
    end
  end
end
