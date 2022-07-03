namespace :result_calulation do
  desc "Calulate daily Avarage"
  task daily: :environment do
    DailyResultStatesCalculationJob.perform_now
  end

  desc "Calulate Monthly Avarage"
  task monthly: :environment do
    MonthlyAveragesCalculationJob.perform_now
  end

end
