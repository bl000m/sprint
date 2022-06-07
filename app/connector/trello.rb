class Trello
  API_KEY = ENV['TRELLO_API_KEY']

  def initialize(token)
    @token = token
  end

  def move_card_to_done_list(task)
    # ...
  end

  def me
    url = URI("https://api.trello.com/1/members/me?key=#{API_KEY}&token=#{@token}")
    get_request(url)
  end

  def boards
    url = URI("https://api.trello.com/1/members/me/boards?key=#{API_KEY}&token=#{@token}")
    get_request(url)
  end

  def card_update_real_time(task)
    real_time_id = task.project.trello_field_real_time_id
    url = URI("https://api.trello.com/1/card/#{task.trello_id}/customField/#{real_time_id}/item")
    query = {
      key: API_KEY,
      token: @token
    }
    body = { value: { number: task.real_time } }
    put_request(url, query, body)
  end

  private

  def put_request(url, query, body)
    url.query = query.to_query
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Put.new(url)
    request["Content-Type"] = "application/json"
    request.body = body.to_json
    response = https.request(request)
    json = response.read_body
    JSON.parse(json)
  end

  def get_request(url)
    url = URI(url)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    json = response.read_body
    JSON.parse(json)
  end
end
