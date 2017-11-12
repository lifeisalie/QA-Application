class Question < ApplicationRecord
	belongs_to :user
	has_many :answers
	validates :qtext, presence: false
	validates :description, presence: true, length: {minimum: 10}
end
