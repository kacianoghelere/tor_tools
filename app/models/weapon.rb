class Weapon < ActiveRecord::Base
	belongs_to :user
	belongs_to :weapon_category
	has_many :npc_weapons
	has_many :npcs, through: :npc_weapons
	has_many :activity_feeds
	validates :name, presence: true, length: { maximum: 50 }
	validates :damage, presence: true
	validates :edge,   presence: true
	validates :injury, presence: true
	validates :weapon_category, presence: true

	def self.all_active
		all.where(deleted: false)
	end
end
