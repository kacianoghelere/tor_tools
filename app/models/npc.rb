class Npc < ActiveRecord::Base
	belongs_to :user
	has_many :equipments, class_name: "NpcWeapon", inverse_of: :npc, 
		:dependent => :destroy
	has_many :weapons, through: :npc_weapons
	has_many :npc_skills
	has_many :skills,  through: :npc_skills
	has_many :party_npcs
	has_many :parties, through: :party_npcs
	has_many :activity_feeds
	accepts_nested_attributes_for :equipments, :allow_destroy => true
	before_save { self.img_url = 'no_image' unless !self.img_url.empty? }

	validates :name,        presence: true, length: { maximum: 50 }
	validates :attr_index,  presence: true, numericality: { only_integer: true }
	validates :resource,    presence: true, numericality: { only_integer: true }
	validates :armour,      presence: true, numericality: { only_integer: true }
	validates :parry,       presence: true, numericality: { only_integer: true }
	validates :personality, presence: true, numericality: { only_integer: true }
	validates :movement,    presence: true, numericality: { only_integer: true }
	validates :perception,  presence: true, numericality: { only_integer: true }
	validates :survival,    presence: true, numericality: { only_integer: true }
	validates :custom,      presence: true, numericality: { only_integer: true }
	validates :vocation,    presence: true, numericality: { only_integer: true }
	validates_inclusion_of :attr_index,  in: 1..12
	validates_inclusion_of :resource,    in: 2..5
	validates_inclusion_of :armour,      in: 1..6
	validates_inclusion_of :parry,       in: 2..5
	validates_inclusion_of :personality, in: 1..3
	validates_inclusion_of :movement,    in: 1..3
	validates_inclusion_of :perception,  in: 1..3
	validates_inclusion_of :survival,    in: 1..3
	validates_inclusion_of :custom,      in: 1..3
	validates_inclusion_of :vocation,    in: 1..3

	def self.search(term)
	  where('LOWER(name) LIKE :term', term: "%#{term.downcase}%")
	end

	def filter_weapons
		Weapon.all_active
	end

	def filter_skills
		Skill.all_active
	end

	def build_equipments
		self.equipments.build.bonus = 1 unless !self.equipments.empty?
	end

	def self.all_active
		all.where(deleted: false)
	end

	def self.newest
		all.where(deleted: false).select(:id, :name, :description, :img_url)
			.order(created_at: :desc).limit(3)
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
