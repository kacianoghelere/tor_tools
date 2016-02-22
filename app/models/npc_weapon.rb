class NpcWeapon < ActiveRecord::Base
	belongs_to :npc
	belongs_to :weapon
	before_save { self.bonus = 1 unless self.bonus > 0 }
	validates :npc_id,      presence: true
	validates :weapon_id,   presence: true
end
