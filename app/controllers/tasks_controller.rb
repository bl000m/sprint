class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
    @review = Review.new
  end

  def create
  @tasks = Task.new(task_params) #=>
    if @task.save
      redirect_to new_projects_url
    else
      render "projects/new"
    end

    def task_params
      params.require(:task).permit(:name, :user_id, :project_id, :done )
    end
end
