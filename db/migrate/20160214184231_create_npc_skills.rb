class CreateNpcSkills < ActiveRecord::Migration
  def change
    create_table :npc_skills do |t|
      t.references :npc, index: true, foreign_key: true
      t.references :skill, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :npc_skills, [:npc_id, :created_at]
    add_index :npc_skills, [:skill_id, :created_at]
  end
end
