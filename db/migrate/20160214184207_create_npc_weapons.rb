class CreateNpcWeapons < ActiveRecord::Migration
  def change
    create_table :npc_weapons do |t|
      t.references :npc, index: true, foreign_key: true
      t.references :weapon, index: true, foreign_key: true
      t.integer :bonus, default: 1

      t.timestamps null: false
    end
    add_index :npc_weapons, [:npc_id, :created_at]
    add_index :npc_weapons, [:weapon_id, :created_at]
  end
end
