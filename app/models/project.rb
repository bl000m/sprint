class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks

  after_create :create_cards

  private

  def create_cards

    # fetch trello api with trello_list_id for get cards
    json = URI.open("https://api.trello.com/1/lists/#{params[:list_id]}/cards?key=#{ENV['TRELLO_API_KEY']}&token=#{current_user.token}")
    data = JSON.parse(json)
    ap data
    @trello_cards = data.map { |element| element.slice('name', 'desc', 'id', 'idMembers')}
    ap @trello_cards

    # create cards in database
    # => tasks_controller

  end
end
