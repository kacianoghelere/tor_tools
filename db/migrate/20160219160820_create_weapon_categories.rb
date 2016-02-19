class CreateWeaponCategories < ActiveRecord::Migration
  def change
    create_table :weapon_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
