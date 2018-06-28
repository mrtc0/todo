class ValidateTask < ActiveRecord::Migration[5.2]
  def change
    # タイトルはNULL禁止で
    change_column_null :tasks, :title, false
    # INDEX
    add_index :tasks, [:title, :description, :priority]
  end
end
