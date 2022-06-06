class Task < ApplicationRecord
  belongs_to :user, primary_key: :trello_id, foreign_key: :trello_member_id, optional: true
  belongs_to :project
  has_many :missions
  has_many :reviews
end
