class DailyResultStatsCalculationJob < ApplicationJob
  queue_as :default

  def perform(date=Date.today-30.days)
    # Do something later
    daily_result = ResultData.daily_result_stats(date).as_json(:except => :id)
    DailyResultStat.upsert_all(daily_result,unique_by: [:date, :subject]) if !daily_result.blank?
  end
end
