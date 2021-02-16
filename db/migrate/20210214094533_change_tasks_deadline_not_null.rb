class ChangeTasksDeadlineNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :deadline, false
  end
end
