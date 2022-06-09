class TasksController < ApplicationController
  before_action :check_redirect_for_new_project, only: [:index]

  def index
    @tasks = current_user.tasks.where(done: nil)
    @done_tasks = current_user.tasks.where.not(done: nil)
    @missions = current_user.missions
    @review = Review.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @mission = Mission.create(task: @task)
  end

  #moving
  def done
    @task = Task.find(params[:id])
    # current_mission&.pause!
    @task&.done!
    Trello.new(current_user.token).move_card_to_done_list(@task)
    render partial: "shared/task_item", locals: { task: @task }, formats: [:html]
  end

  private

  def check_redirect_for_new_project
    redirect_to new_project_path if current_user.tasks.none? && current_user.projects.none?
  end
end
