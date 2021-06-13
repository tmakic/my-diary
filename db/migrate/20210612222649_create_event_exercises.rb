class CreateEventExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :event_exercises do |t|
      t.references :event, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
