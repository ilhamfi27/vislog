class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :message
      t.string :category
      t.boolean :read, default: false

      t.timestamps null: false
    end
  end
end
