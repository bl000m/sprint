class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks
    @missions = current_user.missions
    @review = Review.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @mission = Mission.create(task: @task)
  end

  #ici create cards
  # def create
  #   @task = Task.new(task_params)
  #   if @task.save
  #     redirect_to new_projects_url
  #   else
  #     render "projects/new"
  #   end

  # private

  # def task_params
  #   params.require(:task).permit(:name, :desc, :trello_id_member )
  # end
end
