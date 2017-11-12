class AddAnswerIdToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :answer_id, :integer
  end
end
