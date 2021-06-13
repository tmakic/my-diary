class ChangeExerciseColumnName < ActiveRecord::Migration[6.0]
  def change
      rename_column :exercises, :type, :label
  end
end
