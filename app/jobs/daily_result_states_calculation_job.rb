class DailyResultStatesCalculationJob < ApplicationJob
  queue_as :default

  def perform(date=Date.today)
    # Do something later
    daily_result = ResultData.daily_result_states(date).as_json(:except => :id)
    DailyResultState.upsert_all(daily_result,unique_by: [:date, :subject]) if !daily_result.blank?
  end
end
