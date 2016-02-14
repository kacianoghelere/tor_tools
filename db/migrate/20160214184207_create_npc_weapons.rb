class CreateNpcWeapons < ActiveRecord::Migration
  def change
    create_table :npc_weapons do |t|
      t.references :npc, index: true, foreign_key: true
      t.references :weapon, index: true, foreign_key: true
      t.integer :bonus

      t.timestamps null: false
    end
  end
end
