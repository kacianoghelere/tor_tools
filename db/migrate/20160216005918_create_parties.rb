class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :title
      t.boolean :deleted, :default => false
      t.timestamp :deleted_at
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :parties, [:user_id, :created_at]
  end
end
