class Skill < ActiveRecord::Base
	belongs_to :user
	has_many :npc_skills
	has_many :npcs, through: :npc_skills
	has_many :activity_feeds
	validates :name, presence: true, length: { maximum: 50 }

	def self.all_active
		all.where(deleted: false)
	end
end
