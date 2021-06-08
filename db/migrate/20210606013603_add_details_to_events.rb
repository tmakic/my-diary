class AddDetailsToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :done, :text
    add_column :events, :achievement, :text
    add_column :events, :exercise, :text
  end
end
