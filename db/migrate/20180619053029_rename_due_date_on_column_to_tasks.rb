class RenameDueDateOnColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :due_date_on, :expire_at
  end
end
