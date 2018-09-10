class Task < ApplicationRecord
  belongs_to :list

  validates :task, presence: true
end
