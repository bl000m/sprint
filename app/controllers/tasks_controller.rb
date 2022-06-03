class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks
    @missions = current_user.missions
  end

  def show
    @task = Task.find(params[:id])
    @review = Review.new
  end
end
