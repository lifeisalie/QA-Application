class Question < ApplicationRecord
	has_many :answers
	validates :qtext, presence: true, length: {minimum: 5}
end
