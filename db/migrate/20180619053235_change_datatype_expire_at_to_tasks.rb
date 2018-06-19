class ChangeDatatypeExpireAtToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :expire_at, :datetime
  end
end
