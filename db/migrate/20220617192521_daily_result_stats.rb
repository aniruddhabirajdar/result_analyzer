class DailyResultStats < ActiveRecord::Migration[7.0]
  def change
     create_table :daily_result_stats do |t|
      t.date      :date
      t.string    :subject
      t.decimal   :daily_low
      t.decimal   :daily_high
      t.integer   :result_count
      t.timestamps
    end

    add_index :daily_result_stats, [:date, :subject], unique: true
    
  end
end
