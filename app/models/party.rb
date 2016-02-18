class Party < ActiveRecord::Base
	belongs_to :user
	attr_accessor :members
	has_many :party_npcs, :dependent => :destroy 
	has_many :npcs, through: :party_npcs
	# accepts_nested_attributes_for :members, :reject_if => :all_blank
	validates :title, presence: true, length: { maximum: 50 }

	# Cria o vinculo entre o npc e as armas, deleta anteriores
	def create_npcs(members)
		self.party_npcs.destroy_all
		members.each do |member|
			if !member.empty?
				party_npc = self.party_npcs.create!({npc_id: member[:npc_id], 
						amount: member[:amount]})
			end
		end
	end
end
