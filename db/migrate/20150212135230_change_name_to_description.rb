class ChangeNameToDescription < ActiveRecord::Migration
  def change
    remove_column :tasks, :name
    add_column :tasks, :description, :string
  end
end
