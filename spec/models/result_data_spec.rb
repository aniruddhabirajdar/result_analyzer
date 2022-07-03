require 'rails_helper'
require_relative "common_data_creation.rb"

RSpec.describe ResultData, type: :model do
   describe "Result data calculations for daily avgarge" do
    include_context "Common Data Creation"

    it "provides daily avgarge data with count , daily_high , daily_low" do
      raw_data = new_records
      list_of_subjetcs = raw_data.map{|x| x[:subject]}
      result_state = ResultData.daily_result_states(date_to_test.to_date)
      result_state.each do |subject_row|
        expect(subject_row.result_count).to eq(raw_data.count { |h| h[:subject] == subject_row.subject })
        expect(subject_row.daily_high).to eq( raw_data.group_by { |h| h[:subject] }[subject_row.subject].max_by{ |h| h[:marks] }[:marks] )
        expect(subject_row.daily_low).to eq( raw_data.group_by { |h| h[:subject] }[subject_row.subject].min_by{ |h| h[:marks] }[:marks] )
      end
    end

  end
end
