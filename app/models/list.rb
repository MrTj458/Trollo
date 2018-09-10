class List < ApplicationRecord
  belongs_to :board
  has_many :tasks

  validates :name, presence: true
end
