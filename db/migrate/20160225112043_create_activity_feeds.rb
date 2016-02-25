class CreateActivityFeeds < ActiveRecord::Migration
  def change
    create_table :activity_feeds do |t|
      t.string     :feed_type, null: false
      t.references :npc,       index: true, foreign_key: true
      t.references :skill,     index: true, foreign_key: true
      t.references :weapon,    index: true, foreign_key: true
      t.references :party,     index: true, foreign_key: true
      t.references :user,      index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
    add_index :activity_feeds, [:npc_id, :created_at]
    add_index :activity_feeds, [:skill_id, :created_at]
    add_index :activity_feeds, [:weapon_id, :created_at]
    add_index :activity_feeds, [:party_id, :created_at]
    add_index :activity_feeds, [:user_id, :created_at]
  end
end
