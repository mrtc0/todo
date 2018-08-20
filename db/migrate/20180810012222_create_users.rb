class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, unique: true, null: false
      t.string :password, null: false
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
