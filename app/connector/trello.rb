

class Trello
  API_KEY = ENV['TRELLO_API_KEY']

  def initialize(token)
    @token = token
  end

  #moving
  def move_card_to_done_list(task)
    require "uri"
    require "net/http"

    url = URI("https://api.trello.com/1/cards/#{task.trello_id}?idList=#{task.project.trello_done_list_id}&key=#{API_KEY}&token=#{@token}")
    query = {
      key: API_KEY,
      token: @token
    }

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Put.new(url)
    request["Accept"] = "application/json"
    response = https.request(request)
    puts response.read_body

    # put_request_no_body(url, query)
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

  def put_request_no_body(url, query)
    url.query = query.to_query
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Put.new(url)
    request["Accept"] = "application/json"
    request["Cookie"] = "dsc=607a2cea527a53c4511bb1a895dff9c3e82e730cb1d3bf6c2b60428aa3ba3ede; preAuthProps=s%3A538c8f4bca2e0ce3f80d408b%3AisEnterpriseAdmin%3Dfalse.vPGQqLWI3pdeeJ%2B5Plp5OmMk78I5711%2Fe4ppzrVpFYo"
    response = https.request(request)
    puts response.read_body
    # JSON.parse(json)


    # https = Net::HTTP.new(url.host, url.port)
    # https.use_ssl = true
    # request = Net::HTTP::Put.new(url)
    # request["Accept"] = "application/json"
    # response = https.request(request)
    # puts response.read_body
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
