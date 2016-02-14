class NpcSkill < ActiveRecord::Base
	belongs_to :npc
	belongs_to :skill
	validates :npc_id,   presence: true
	validates :skill_id, presence: true
end
