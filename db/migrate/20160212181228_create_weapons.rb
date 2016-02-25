class CreateWeapons < ActiveRecord::Migration
  def change
    create_table :weapons do |t|
      t.string :name
      t.integer :damage
      t.integer :edge
      t.integer :injury
      t.boolean :deleted, :default => false
      t.timestamp :deleted_at
      t.references :user, index: true, foreign_key: true
      t.references :weapon_category, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :weapons, [:user_id, :created_at]
    add_index :weapons, [:weapon_category_id, :created_at]
  end
end
