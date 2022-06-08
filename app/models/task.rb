class Task < ApplicationRecord
  belongs_to :user, primary_key: :trello_id, foreign_key: :trello_member_id, optional: true
  belongs_to :project
  has_many :missions, dependent: :destroy
  has_many :reviews

  #moving
  def done!
    update(done: true)
  end

  def total_time_of_terminated_missions
    select_sql = <<~SQL
      *,
      extract(epoch from (end_at - created_at)) AS difference
    SQL
      seconds_to_hms(missions.where.not(end_at: nil).select(select_sql).map(&:difference).sum)
  end

  def synchro_real_time
    Trello.new(project.user.token).card_update_real_time(self)
  end

  def seconds_to_hms(sec)
    "%02d:%02d:%02d" % [sec / 3600, sec / 60 % 60, sec % 60]
  end
end

require "uri"
require "json"
require "net/http"

url = URI("https://api.trello.com/1/card/629efd20242fe507a40f4587/customField/629f808660918e05be8b02a0/item?token=1a2789645a50b692c636125bc0c299b5011b379c36da45151e358e5aa9542fae&key=873e4ba0cea73aac5f84e2b006ed257c")

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Put.new(url)
request["Accept"] = "application/json"
request["Content-Type"] = "application/json"
request["Cookie"] = "dsc=607a2cea527a53c4511bb1a895dff9c3e82e730cb1d3bf6c2b60428aa3ba3ede; preAuthProps=s%3A538c8f4bca2e0ce3f80d408b%3AisEnterpriseAdmin%3Dfalse.vPGQqLWI3pdeeJ%2B5Plp5OmMk78I5711%2Fe4ppzrVpFYo"
request.body = JSON.dump({
  "value": {
    "number": "1111"
  }
})

response = https.request(request)
puts response.read_body
