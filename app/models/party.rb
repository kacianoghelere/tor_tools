class Party < ActiveRecord::Base
	belongs_to :user
	has_many :party_npcs
	has_many :npcs, through: :party_npcs
	validates :title, presence: true, length: { maximum: 50 }
end
