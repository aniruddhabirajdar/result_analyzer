class DailyResultState < ApplicationRecord
    scope :get_by_between_date , -> (start_date,end_date) { where(:date => start_date.beginning_of_day..end_date.end_of_day) }
    scope :group_by_subject , -> { group(:subject) }
    scope :get_by_subject , -> (subject) { where(subject: subject ) }    

    # start_date = Date.new(2022,05,25)
    # end_date = Date.new(2022,05,25)

    def self.averages_by_date(start_date,end_date)
        self.get_by_between_date( start_date, end_date )
                            .select("subject,max(date) as date, ROUND(avg(daily_low),2) as monthly_avg_low,ROUND(avg(daily_high),2) as monthly_avg_high,SUM(result_count) as monthly_result_count_used") 
                            .group_by_subject
    end

    def self.monthly_averages_by_subject(subjects,start_date,end_date)
        self.averages_by_date( start_date, end_date )
                            .get_by_subject(subjects).group_by_subject
    end

    def self.monthly_averages_sum_threshold(subjects, date, data_threshold=nil)
        start_date = date - 1.days
        pending_subjects = subjects
        monthly_avrage_data = []
        start_date.downto(start_date-Rails.configuration.average[:month_max_loock_back].days).each do |start_d|
            monthly_avg = self.monthly_averages_by_subject( pending_subjects, start_d, date ).having("SUM(result_count) > #{data_threshold ||= Rails.configuration.average[:monthly_avarage_threshold]}")
            monthly_avrage_data += monthly_avg
            pending_subjects = pending_subjects - monthly_avg.map(& :subject)
            return monthly_avrage_data if pending_subjects.size <= 0 
        end
        monthly_avrage_data
    end
    
end
