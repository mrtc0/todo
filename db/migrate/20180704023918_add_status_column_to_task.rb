class AddStatusColumnToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :integer, default: 0
    # わざとindexは貼りません
    # 今後の作業内容で 検索インデックスを貼りましょう があり、
    # 速度が改善されることを確認する作業があるため
  end
end
