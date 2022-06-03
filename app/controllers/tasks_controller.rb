class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks
  end

  def show
    @task = Task.find(params[:id])
    @review = Review.new
  end

  #ici create cards
  # def create
  #   @task = Task.new(task_params)
  #   if @task.save
  #     redirect_to new_projects_url
  #   else
  #     render "projects/new"
  #   end

  private

  def task_params
    params.require(:task).permit(:name, :desc, :trello_id_member )
  end
end
