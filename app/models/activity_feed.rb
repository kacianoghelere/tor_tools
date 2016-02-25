class ActivityFeed < ActiveRecord::Base
	belongs_to :npc
	belongs_to :skill
	belongs_to :weapon
	belongs_to :party
	belongs_to :user 
	validates_inclusion_of :feed_type, in: %w( insertion updated destroyed ), 
																				message: "%{value} não é permitido"
	def describe_action
		if self.npc
			operation = "NPC's: <b>#{self.npc.name}</b> "
		elsif self.skill
			operation = "Habilidades: <b>#{self.skill.name}</b> "
		elsif self.party
			operation = "Grupos: <b>#{self.party.title}</b> "
		elsif self.weapon
			operation = "Armas: <b>#{self.weapon.name}</b> "
		else
			'Modelo desconhecido'
		end

		if self.feed_type    === "insertion"
			description = "#{operation} catalagado(a) no sistema!"
		elsif self.feed_type === "updated"
			description = "#{operation} foi atualizado(a)!"
		elsif self.feed_type === "destroyed"
			description = "#{operation} removido(a) do sistema!"
		else
			description = 'Operação desconhecida'
		end
		description.html_safe
	end																				
end
