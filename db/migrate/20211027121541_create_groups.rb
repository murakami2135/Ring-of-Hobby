class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.index :name, unique: true
      t.text :overview
      t.string :image_id
      t.timestamps
    end
  end
end
