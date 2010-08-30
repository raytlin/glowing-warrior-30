class AddPositionToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :position, :integer, :null => false
  end

  def self.down
    remove_column :reviews, :position
  end
end
