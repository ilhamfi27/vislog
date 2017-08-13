class CreateTableUserActivityRecord < ActiveRecord::Migration
  def change
    create_table :activity_records do |t|
      t.string :username
      t.string :note
      t.string :user_ip
      t.string :browser
      t.string :controller
      t.string :action
      t.text :params

      t.timestamps null:false
    end
  end
end
