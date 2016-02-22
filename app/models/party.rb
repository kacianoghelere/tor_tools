class Party < ActiveRecord::Base
	belongs_to :user
	has_many :members, class_name: "PartyNpc", inverse_of: :party, 
		:dependent => :destroy 
	has_many :npcs, through: :members
	accepts_nested_attributes_for :members, :allow_destroy => true
	validates :title, presence: true, length: { maximum: 50 }

	def reject_party_npcs(attributed)
		attributed['id'].blank?
	end

	def filter_npcs
		Npc.all #.where('"id" NOT IN (?)', self.npcs.map { |x| x.id } )
	end

	def build_members
		self.members.build.amount = 1 unless !self.members.empty?
	end
end
