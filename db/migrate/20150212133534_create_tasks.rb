class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.belongs_to :list, index:true # belongs_to :list_id
      t.boolean :done
      t.datetime :due_date
    end
  end
end
