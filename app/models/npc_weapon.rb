class NpcWeapon < ActiveRecord::Base
	belongs_to :npc
	belongs_to :weapon
	validates :npc_id,    presence: true
	validates :weapon_id, presence: true
end
