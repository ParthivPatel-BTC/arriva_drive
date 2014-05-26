class AddActivityIdToReview < ActiveRecord::Migration
  def change
    add_reference :reviews, :activity, index: true
  end
end
