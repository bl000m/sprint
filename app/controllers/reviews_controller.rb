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
      post_trello_comment
      redirect_to tasks_path
    else
      render "reviews/show"
    end
  end

  def post_trello_comment
    Trello.new(current_user.token).send_feedback_to_trello(@task, @review)
  end

  private

  def review_params
    params.require(:review).permit(:feedback)
  end
end
