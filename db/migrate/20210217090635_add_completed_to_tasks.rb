class AddCompletedToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :completed, :integer, default: 0, null: false
  end
end
