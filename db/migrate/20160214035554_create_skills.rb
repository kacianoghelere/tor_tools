class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.integer :cost
      t.string :description
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :skills, [:user_id, :created_at]
  end
end
