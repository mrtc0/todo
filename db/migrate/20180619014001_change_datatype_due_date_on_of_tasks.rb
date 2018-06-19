class ChangeDatatypeDueDateOnOfTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :due_date_on, :date
  end
end
