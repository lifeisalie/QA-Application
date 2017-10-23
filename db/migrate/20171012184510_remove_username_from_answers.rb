class RemoveUsernameFromAnswers < ActiveRecord::Migration[5.1]
  def change
    remove_column :answers, :username, :string
  end
end
