require 'rails_helper'

RSpec.describe DailyResultState, type: :model do
 describe "Result data calculations for Montly avgarge with correct data" do
   let!(:threshold_date_to_test) {Faker::Time.backward(days: 0, period: :evening).to_date}
   let!(:threshold_subject) {"Science"}
   let!(:threshold_records) do    
    data = [
      {date: threshold_date_to_test.to_date - 11.days, subject: threshold_subject, daily_low: 119.88, daily_high: 126.76, result_count: 18 },
      {date: threshold_date_to_test.to_date - 10.days, subject: threshold_subject, daily_low: 123.73, daily_high: 127.23, result_count: 11 },
      {date: threshold_date_to_test.to_date - 7.days, subject: threshold_subject, daily_low:  121.12, daily_high: 124.52, result_count: 12 },
      {date: threshold_date_to_test.to_date - 6.days, subject: threshold_subject, daily_low: 117.22, daily_high: 120.11, result_count: 81 },
      {date: threshold_date_to_test.to_date - 5.days, subject: threshold_subject, daily_low: 118.84, daily_high: 119.29, result_count: 22 },
      {date: threshold_date_to_test.to_date - 4.days, subject: threshold_subject, daily_low: 120.27, daily_high: 123.33, result_count: 57 },
      {date: threshold_date_to_test.to_date - 3.days, subject: threshold_subject, daily_low: 126.01, daily_high: 128.77, result_count: 23 },
      {date: threshold_date_to_test.to_date, subject: threshold_subject, daily_low: 124.30 , daily_high: 125.58, result_count: 12 }
    ]
    DailyResultState.insert_all(data)
   end

  it "provides Monthly avgarge between the two dates " do
    threshold_records
    subject_list = DailyResultState.distinct.pluck(:subject)
    montly_result = DailyResultState.monthly_averages_sum_threshold([subject_list[0]],threshold_date_to_test)
    expect(montly_result.count).to be(1)
    expect(montly_result.first.monthly_avg_low).to be(121.29)
    expect(montly_result.first.monthly_avg_high).to be(123.60)
    expect(montly_result.first.monthly_result_count_used).to be(207)
  end
 end


 describe "Result data calculations for Montly avgarge without threshold data" do
   let!(:non_threshold_date_to_test) {Faker::Time.backward(days: 31, period: :evening).to_date}
   let!(:non_threshold_subject) {Faker::Educator.subject}
   let!(:non_threshold_records) do    
    data2 = [
      {date: non_threshold_date_to_test.to_date - 11.days, subject: non_threshold_subject, daily_low: 119.88, daily_high: 126.76, result_count: 1 },
      {date: non_threshold_date_to_test.to_date - 10.days, subject: non_threshold_subject, daily_low: 123.73, daily_high: 127.23, result_count: 1 },
      {date: non_threshold_date_to_test.to_date - 7.days, subject: non_threshold_subject, daily_low:  121.12, daily_high: 124.52, result_count: 1 },
      {date: non_threshold_date_to_test.to_date - 6.days, subject: non_threshold_subject, daily_low: 117.22, daily_high: 120.11, result_count: 1 },
      {date: non_threshold_date_to_test.to_date - 5.days, subject: non_threshold_subject, daily_low: 118.84, daily_high: 119.29, result_count: 22 },
      {date: non_threshold_date_to_test.to_date - 4.days, subject: non_threshold_subject, daily_low: 120.27, daily_high: 123.33, result_count: 57 },
      {date: non_threshold_date_to_test.to_date - 3.days, subject: non_threshold_subject, daily_low: 126.01, daily_high: 128.77, result_count: 23 },
      {date: non_threshold_date_to_test.to_date, subject: non_threshold_subject, daily_low: 124.30 , daily_high: 125.58, result_count: 12 }
    ]
    DailyResultState.insert_all(data2)
   end

  

  it "provides Monthly avgarge between the two dates " do
    non_threshold_records
    subject_list = DailyResultState.distinct.pluck(:subject)
    montly_result = DailyResultState.monthly_averages_sum_threshold([subject_list[0]],non_threshold_date_to_test)
    expect(montly_result.count).to be(0)
  end
 end

end
