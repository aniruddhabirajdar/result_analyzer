class MonthlyAverages < ActiveRecord::Migration[7.0]
  def change

    create_table :monthly_averages do |t|
      t.date      :date
      t.string    :subject
      t.decimal   :monthly_avg_low
      t.decimal   :monthly_avg_high
      t.integer   :monthly_result_count_used
      t.timestamps
    end

    add_index :monthly_averages, [:date, :subject], unique: true

  end
end
