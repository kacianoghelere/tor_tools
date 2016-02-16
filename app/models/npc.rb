class Npc < ActiveRecord::Base
	belongs_to :user

	has_many :npc_weapons
	has_many :weapons, through: :npc_weapons

	has_many :npc_skills
	has_many :skills,  through: :npc_skills

	has_many :party_npcs
	has_many :parties, through: :party_npcs

	validates :name, presence: true, length: { maximum: 50 }
	validates :personality, presence: true
	validates :movement,    presence: true
	validates :perception,  presence: true
	validates :survival,    presence: true
	validates :custom,      presence: true
	validates :vocation,    presence: true
end
