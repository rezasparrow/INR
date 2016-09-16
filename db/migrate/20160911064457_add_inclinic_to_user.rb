class AddInclinicToUser < ActiveRecord::Migration
  def change
    add_column :users, :inclinic, :string
  end
end
