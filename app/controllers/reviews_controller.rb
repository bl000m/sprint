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
      redirect_to tasks_path(@task)
    else
      render "reviews/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:feedback)
  end
end
