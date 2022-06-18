class DailyResultStat < ApplicationRecord
    scope :get_by_between_date , -> (start_date,end_date) { where(:date => start_date.beginning_of_day..end_date.end_of_day) }
    scope :group_by_subject , -> { group(:subject) }
    scope :get_by_subject , -> (subject) { where(subject: subject ) }    

    # start_date = Date.new(2022,05,25)
    # end_date = Date.new(2022,05,25)

    def self.monthly_averages(subject,start_date,end_date)
        self.get_by_between_date( start_date, end_date )
                            .select("date,min(daily_low) as monthly_avg_low,max(daily_high) as monthly_avg_high,SUM(result_count) as monthly_result_count_used") 
                            .get_by_subject(subject).group_by_subject
    end

    def self.monthly_averages_sum_threshold(subject,end_date)
        start_date = end_date - 5.days
        start_date.downto(start_date-30.days).each do |start_d|
            monthly_avg = self.monthly_averages( subject,start_d, end_date ).first
            return monthly_avg if monthly_avg && monthly_avg.monthly_result_count_used > 200
        end
        []
    end
    
end
