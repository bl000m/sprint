# frozen_string_literal: true
# in developent, if you start Rails by `NGROK_URL = http://xxxxxxxx.ngrok.io rails server`,
# you can use rails route suffix url properly, then you can communicate with an extern api.
# (We implement that for use AWS lambda in development)
url = ENV['APP_URL'] || 'http://localhost:3000'
uri = URI(url)
Rails.application.routes.default_url_options = { host: uri.host,
                                                 port: uri.port,
                                                 protocol: uri.scheme }
Rails.application.config.action_mailer.asset_host = url
