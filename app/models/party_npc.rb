class PartyNpc < ActiveRecord::Base
	belongs_to :party
	belongs_to :npc
	before_save { self.amount = 1 unless self.amount > 0 }
	validates_presence_of :party
	validates_presence_of :npc
end
