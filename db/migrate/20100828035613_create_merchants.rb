class CreateMerchants < ActiveRecord::Migration
  def self.up
    create_table :merchants do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :web_address
      t.string :image_path

      t.timestamps
    end
  end

  def self.down
    drop_table :merchants
  end
end
