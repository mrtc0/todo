class AddIndexToUserIdColumnOfTask < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :user_id
  end
end
