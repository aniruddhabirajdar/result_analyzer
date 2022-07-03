require "rails_helper"
require "fugit"


RSpec.describe "sidekiq-scheduler" do
  sidekiq_file = File.join(Rails.root, "config", "schedule.yml")
  schedule = HashWithIndifferentAccess.new(YAML.load_file(sidekiq_file))

  describe "cron syntax" do
    schedule.each do |k, v|
        cron = v["cron"]
        it "#{k} has correct cron syntax" do
            expect { Fugit.do_parse(cron) }.not_to raise_error
        end
    end
  end

    describe "job classes" do
        schedule.each do |k, v|
            klass = v["class"]
            it "#{k} has #{klass} class in /jobs" do
            expect { klass.constantize }.not_to raise_error
            end
        end
    end

    describe "Monthly job " do
        it "should enque on third monday of month" do
            job = Sidekiq::Cron::Job.find :monthly_average
           Fugit.parse(job.cron).match?((NthDay.next_occurrence("3rd Monday").midnight + 1.minute).strftime("%Y-%m-%d %H:%M:%S"))
        end
    end


end
