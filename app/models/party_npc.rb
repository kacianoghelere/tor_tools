class PartyNpc < ActiveRecord::Base
  belongs_to :party
  belongs_to :npc
end
