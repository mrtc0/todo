class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false, index: true
      t.text :description, index: true
      t.string :status
      t.string :priolity
      t.datetime :deadline
      t.references :label, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
