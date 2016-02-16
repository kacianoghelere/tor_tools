class CreatePartyNpcs < ActiveRecord::Migration
  def change
    create_table :party_npcs do |t|
      t.references :party, index: true, foreign_key: true
      t.references :npc, index: true, foreign_key: true
      t.integer :amount

      t.timestamps null: false
    end
    add_index :party_npcs, [:party_id, :created_at]
    add_index :party_npcs, [:npc_id, :created_at]
  end
end
