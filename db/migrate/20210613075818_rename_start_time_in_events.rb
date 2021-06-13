class RenameStartTimeInEvents < ActiveRecord::Migration[6.0]
  def change
      rename_column :events, :start_time, :start_date
  end
end
