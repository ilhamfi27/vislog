class AddProfilDataColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, default: ""
    add_column :users, :company, :string, default: ""
    add_column :users, :phone, :string, default: ""
    add_column :users, :avatar, :string
  end
end
