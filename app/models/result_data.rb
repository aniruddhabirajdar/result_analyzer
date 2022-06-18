class ResultData < ApplicationRecord
    scope :get_by_date , -> (date) { where(timestamp: date.all_day) }

    def self.daily_result_stats(date)
        self.get_by_date(date).select("DATE(timestamp) as 'date',subject, max(marks) as daily_high , min(marks) as daily_low, count(id) as result_count ").group(:subject)#.as_json(:except => :id)
    end

end