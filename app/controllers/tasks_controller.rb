class TasksController < ApplicationController
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
end
