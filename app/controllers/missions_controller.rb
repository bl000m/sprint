class MissionsController < ApplicationController
  before_action :set_mission, only: [:show, :edit, :update, :destroy]

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new
    @mission.user = current_user
    @mission.start_at = Time.now
    @mission.task = Task.find(params[:task_id])
    respond_to do |format|
      if @mission.save
        format.html { redirect_to tasks_path(@mission.task) }
        format.text { render partial: "shared/timer", locals: { mission: @mission, task: @mission.task }, formats: [:html] }
      else
        format.html render 'tasks/index'
      end
    end
  end


  def show
    @task = @mission.task
  end

  def index
    # user = @missions.current_user
    @missions = current_user.missions
  end

  def edit
  end

  def update
    if @mission.update(mission_params)
      redirect_to @mission, notice: 'mission was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @mission.destroy
    redirect_to @task, notice: 'mission was successfully destroyed.'
  end

  private

  def set_mission
    @mission = Mission.find(params[:id])
  end
end
