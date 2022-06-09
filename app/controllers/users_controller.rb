class UsersController < ApplicationController
  include Devise::Controllers::Helpers

  OAUTH_CONSUMER = OAuth::Consumer.new(ENV['TRELLO_API_KEY'], ENV['TRELLO_SECRET'],
                                        {
                                          site: "https://trello.com/",
                                          access_token_url: "https://trello.com/1/OAuthGetAccessToken",
                                          authorize_url: "https://trello.com/1/OAuthAuthorizeToken",
                                          request_token_url: "https://trello.com/1/OAuthGetRequestToken"
                                        }
                                      )

  skip_before_action :authenticate_user!

  def connect_trello_account
    trello_url_to_get_token = request_token.authorize_url(scope: 'read,write,account', name: 'Sprint', expiration: 'never')
    redirect_to trello_url_to_get_token
  end

  def connect_trello_account_callback
    oauth_verifier = params[:oauth_verifier]
    res = request_token.get_access_token(oauth_verifier: oauth_verifier)
    @secret = res.secret
    @token = res.token


    trello_id = trello_user['id']
    trello_email = trello_user['email']

    user = User.find_or_initialize_by(trello_id: trello_id)
    user.update(token: @token, secret: @secret, email: trello_email)
    sign_in(user)
    redirect_to tasks_path
  end

  private

  def contact_params
    params.require(:user).permit(:token, :secret)
  end

  def request_token
    OAUTH_CONSUMER.get_request_token(oauth_callback: users_connect_trello_account_callback_url)
  end

  def check_trello_token
    redirect_to users_connect_trello_account_path if current_user.token.nil?
  end

  def trello_user
    @trello_user ||= Trello.new(@token).me
  end
end
