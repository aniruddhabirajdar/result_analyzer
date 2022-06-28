require "faker"
namespace :test_data do
  desc "create data to test"
  task :dump => :environment do
    data = []
    ((Date.today - 30)..Date.today).each do |date|
    5000.times do |x|
      data << {
        subject: Faker::Educator.subject,
        timestamp: date + Time.parse(Faker::Time.backward(days: 0, period: :evening).strftime("%I:%M%p")).seconds_since_midnight.seconds,
        marks: Faker::Number.decimal(l_digits: 2.2)
      }
    end
  end
    # p data
    ResultData.insert_all(data)
    # DailyResultStat.insert_all(ResultData.daily_result_stats(date).as_json(:except => :id) )
  end
end
