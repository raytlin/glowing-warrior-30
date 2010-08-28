class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.text :comment
      t.integer :score
      t.integer :user_id
      t.integer :merchant_id

      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end
