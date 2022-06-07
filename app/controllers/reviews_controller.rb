class ReviewsController < ApplicationController
  def index
    @reviews = Reviews.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def create
    @task = Task.find(params[:task_id])
    @review = Review.new(review_params)
    @review.task = @task
    if @review.save


      redirect_to task_path(@task)

    else
      render "reviews/show"
    end
  end

  def post_trello_comment
    url = URI("https://api.trello.com/1/cards/629728b2f5cce82bc011d3fa/actions/comments")
    
    data = {
      key: ENV['TRELLO_API_KEY'],
      token: current_user.token,
      text: @review.feedback
    }
    url.query = data.to_query

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    response = https.request(request)
    puts response.read_body
  end

  private

  def review_params
    params.require(:review).permit(:feedback)
  end
end
