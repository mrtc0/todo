class PriorityMigrateToEnum < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :priority, 0
  end
end
