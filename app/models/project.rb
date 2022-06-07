class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  after_create :create_cards
  after_create :create_custom_field

  CUSTOM_FIELD_REAL_NAME = 'Temps réel'

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
      # TODO Je dois aller chercher le champs de la durée estimé pour ajouter un time estimé à ma card
      url_custom = "https://api.trello.com/1/boards/#{trello_board_id}/customFields?key=#{ENV['TRELLO_API_KEY']}&token=#{user.token}"
      json = URI.open(url_custom).read
      data = JSON.parse(json)
    @task.trello_field_estimated_time_id =   data.name['estimated time']

      @task = Task.create!(project: self, name: element['name'], desc: element['desc'], trello_id: element['id'], trello_member_id: element['idMembers'].first )
    end
  end

  def create_custom_field
    # list custom field
    # find custom field with name CUSTOM_FIELD_REAL_NAME
    #   if exist
    #     save it s id in project model
    #   else
    #     create new custom field (api)
    #     save it s id in project model
    #   end
  end
end
