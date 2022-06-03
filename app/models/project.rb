class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks

  after_create :create_cards

  private

  def create_cards
    # fetch trello api with trello_list_id for get cards
    # create cards in database
  end
end
