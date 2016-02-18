class Party < ActiveRecord::Base
	belongs_to :user
	has_many :party_npcs, inverse_of: :party, :dependent => :destroy 
	has_many :npcs, through: :party_npcs
	accepts_nested_attributes_for :party_npcs, :allow_destroy => true
	validates :title, presence: true, length: { maximum: 50 }

	def reject_party_npcs(attributed)
		attributed['id'].blank?
	end

	def filter_npcs
		Npc.all #.where('"id" NOT IN (?)', self.npcs.map { |x| x.id } )
	end

	def build_party_npcs
		self.party_npcs.build.amount = 1 unless !self.party_npcs.empty?
	end
end
