class Task < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :reviews
  has_many :missions
end
