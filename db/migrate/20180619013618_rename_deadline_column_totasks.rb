class RenameDeadlineColumnTotasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :deadline, :due_date_on
  end
end
