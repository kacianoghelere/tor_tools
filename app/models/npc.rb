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

	def self.search(term)
	  where('LOWER(name) LIKE :term', term: "%#{term.downcase}%")
	end

	# Cria o vinculo entre o npc e as armas, deleta anteriores
	def create_weapons(weapons)
		self.npc_weapons.destroy_all
		weapons.each do |weapon|
			if !weapon.empty?
				self.npc_weapons.create({weapon_id: weapon.to_i})
			end
		end
	end

	# Cria o vinculo entre o npc e as habilidades, deleta anteriores
	def create_skills(skills)
		self.npc_skills.destroy_all
		skills.each do |skill|
			if !skill.empty?
			 	self.npc_skills.create({skill_id: skill.to_i})
			end
		end
	end
end
