class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  after_create :create_cards

  private

  def create_cards
    ap self
    # fetch trello api with trello_list_id for get cards
    url = "https://api.trello.com/1/lists/#{trello_list_id}/cards?key=#{ENV['TRELLO_API_KEY']}&token=#{user.token}"
    ap "je suis al"
    ap url
    json = URI.open(url).read
    data = JSON.parse(json)
    ap data
    @trello_cards = data.map { |element| element.slice('name', 'desc', 'id', 'idMembers')}

    @trello_cards.each do |element|
      ap "je veux créer une task"
      ap element
      @task = Task.create!(project: self, name: element['name'], desc: element['desc'], trello_id: element['id'], trello_member_id: element['idMembers'].first )
    end
  end
end
