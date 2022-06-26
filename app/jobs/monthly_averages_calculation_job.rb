class MonthlyAveragesCalculationJob < ApplicationJob
  queue_as :default

  def perform(date)
    # Do something later
    DailyResultStat.monthly_averages_sum_threshold(DailyResultStat.distinct.pluck(:subject),date).as_json(:except => :id)

  end
end
