class AddIndex < ActiveRecord::Migration[7.0]
  def change
     add_index :daily_result_stats, [:date, :subject], unique: true
  end
end
