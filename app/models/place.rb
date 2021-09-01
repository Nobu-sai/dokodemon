class Place < ApplicationRecord
	has_many :place_comments
	validates :name, presence: true, length: { maximum: 140 }

end

