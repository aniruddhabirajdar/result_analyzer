RSpec.configure do |rspec|
  # This config option will be enabled by default on RSpec 4,
  # but for reasons of backwards compatibility, you have to
  # set it on RSpec 3.
  #
  # It causes the host group and examples to inherit metadata
  # from the shared context.
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context "Common Data Creation", :shared_context => :metadata do
  
    let!(:date_to_test) {Faker::Time.backward(days: 0, period: :evening)}
    let!(:new_records) do     
      date = date_to_test
      data = []
     
      30.times do |x|
        data << {
          subject: Faker::Educator.subject,
          timestamp: date,
          marks: Faker::Number.decimal(l_digits: 2.2)
        }
      end
      ResultData.insert_all(data)

      # diffrent date data
      10.times do |x|
        ResultData.create( {
          subject: Faker::Educator.subject,
          timestamp: date_to_test - 10.days ,
          marks: Faker::Number.decimal(l_digits: 2.2)
        } )
      end

      data
    end

end

RSpec.configure do |rspec|
  rspec.include_context "Common Data Creation", :include_shared => true
end