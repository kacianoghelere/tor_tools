class Party < ActiveRecord::Base
	belongs_to :user
	has_many :members, class_name: "PartyNpc", inverse_of: :party, 
		:dependent => :destroy 
	has_many :npcs, through: :members
	has_many :activity_feeds
	accepts_nested_attributes_for :members, :allow_destroy => true
	validates :title, presence: true, length: { maximum: 50 }

	def reject_party_npcs(attributed)
		attributed['id'].blank?
	end

	def filter_npcs
		Npc.all_active
	end

	def self.all_active
		all.where(deleted: false)
	end

	def build_members
		self.members.build.amount = 1 unless !self.members.empty?
	end
end
