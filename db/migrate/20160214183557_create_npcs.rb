class CreateNpcs < ActiveRecord::Migration
  def change
    create_table :npcs do |t|
      t.string :name
      t.string :description
      t.string :img_url
      t.boolean :ally, :default => false
      t.integer :attr_index,  :null => false, :default => 1
      t.integer :resistance,  :null => false, :default => 1
      t.integer :resource,    :null => false, :default => 1
      t.integer :parry,       :null => false, :default => 1
      t.integer :armour,      :null => false, :default => 1
      t.integer :personality, :null => false, :default => 1
      t.integer :movement,    :null => false, :default => 1
      t.integer :perception,  :null => false, :default => 1
      t.integer :survival,    :null => false, :default => 1
      t.integer :custom,      :null => false, :default => 1
      t.integer :vocation,    :null => false, :default => 1
      t.boolean :deleted, :default => false
      t.timestamp :deleted_at
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :npcs, [:user_id, :created_at]
  end
end
