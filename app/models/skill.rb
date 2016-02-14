class Skill < ActiveRecord::Base
	belongs_to :user
	has_many :npc_skills
	has_many :npcs, through: :npc_skills
	validates :name, presence: true, length: { maximum: 50 }
end
