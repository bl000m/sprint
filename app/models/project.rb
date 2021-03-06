require 'open-uri'

class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  after_create :create_cards
  after_create :add_custom_field_real_time!

  CUSTOM_FIELD_REAL_NAME = 'Real time'

  # only create to be call manually by developer
  def reset!
    Trello.new(user.token).reset_project(self)
  end

  private

  def create_cards
    url = "https://api.trello.com/1/lists/#{trello_list_id}/cards?key=#{ENV['TRELLO_API_KEY']}&token=#{user.token}&customFieldItems=true"
    json = URI.open(url).read
    @trello_cards = JSON.parse(json)
    # @trello_cards = data.map { |element| element.slice('name', 'desc', 'id', 'idMembers', 'customFieldItems')}

    @trello_cards.each do |element|
      estimated_time = element['customFieldItems'].find { |item| item['idCustomField'] == trello_field_estimated_time_id }['value']['number'].to_f
      @task = tasks.create!(estimated_time: estimated_time, name: element['name'], desc: element['desc'], trello_id: element['id'], trello_member_id: element['idMembers'].first )
    end
  end

  def add_custom_field_real_time!
    custom_fields = get_custom_fields
    custom_field_real_item = custom_fields.find { |custom_field| custom_field['name'] == CUSTOM_FIELD_REAL_NAME }
    custom_field_real_item = create_custom_field_real_time! if custom_field_real_item.nil?
    update(trello_field_real_time_id: custom_field_real_item['id'])
  end

  def get_custom_fields
    url_board_custom_fields = "https://api.trello.com/1/boards/#{trello_board_id}/customFields?key=#{ENV['TRELLO_API_KEY']}&token=#{user.token}"
    json = URI.open(url_board_custom_fields).read
    JSON.parse(json)
  end

  def create_custom_field_real_time!
    url = URI("https://api.trello.com/1/customFields?key=#{ENV['TRELLO_API_KEY']}&token=#{user.token}&idModel=#{trello_board_id}&modelType=board&name=#{CUSTOM_FIELD_REAL_NAME}&type=number&pos=10")
    ap url
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    response = https.request(request)
    json = response.read_body
    ap "laaa"
    ap json
    JSON.parse(json)
  end
end
