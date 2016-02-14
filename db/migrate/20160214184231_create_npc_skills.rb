class CreateNpcSkills < ActiveRecord::Migration
  def change
    create_table :npc_skills do |t|
      t.references :npc, index: true, foreign_key: true
      t.references :skill, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
