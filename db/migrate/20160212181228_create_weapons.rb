class CreateWeapons < ActiveRecord::Migration
  def change
    create_table :weapons do |t|
      t.string :name
      t.integer :damage
      t.integer :edge
      t.integer :injury
      t.string :enc
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :weapons, [:user_id, :created_at]
  end
end
