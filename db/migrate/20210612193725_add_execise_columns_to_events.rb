class AddExeciseColumnsToEvents < ActiveRecord::Migration[6.0]
  def change
      add_column :events, :exercise_upper_arms, :boolean, default: false
      add_column :events, :exercise_abs, :boolean, default: false
      add_column :events, :exercise_hamstrings, :boolean, default: false
      add_column :events, :exercise_legs, :boolean, default: false
  end
end
