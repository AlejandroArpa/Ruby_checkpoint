class ChangeStateDefaultInPosts < ActiveRecord::Migration[7.2]
  def change
    change_column_default :posts, :state, false
  end
end
