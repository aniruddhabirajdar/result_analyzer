class MonthlyAveragesCalculationJob < ApplicationJob
  queue_as :default

  def perform(date=Date.today-30.days)
    # Do something later
    MonthlyAverage.upsert_all(DailyResultStat.monthly_averages_sum_threshold(DailyResultStat.distinct.pluck(:subject),date).as_json(:except => :id))

  end
end
