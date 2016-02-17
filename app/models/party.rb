class Party < ActiveRecord::Base
	belongs_to :user
	attr_accessor :members
	has_many :party_npcs, :dependent => :destroy 
	has_many :npcs, through: :party_npcs
	# accepts_nested_attributes_for :members, :reject_if => :all_blank
	validates :title, presence: true, length: { maximum: 50 }
end
