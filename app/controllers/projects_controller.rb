require 'open-uri'

class ProjectsController < ApplicationController
  def new
    # @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    @project.save!
    redirect_to tasks_url
  end

  def new_boards
    getTrelloBoards
    render partial: 'new_boards', locals: {boards: @boards}
  end

  def form
    getTrelloLists
    getTrelloCustomFields

    ap "je suis la"
    ap @trello_custom_fields

    project = Project.new(name: params[:name], trello_board_id: params[:board_id])
    render partial: 'form', locals: {project: project, trello_lists: @trello_lists, trello_custom_fields: @trello_custom_fields}
  end

  private

  def getTrelloBoards
    @boards = Trello.new(current_user.token).boards.map { |board| board.slice('name', 'id') }
  end

  def getTrelloLists
    json = URI.open("https://api.trello.com/1/boards/#{params[:board_id]}/lists?key=#{ENV['TRELLO_API_KEY']}&token=#{current_user.token}").read
    data = JSON.parse(json)
    ap data
    @trello_lists = data.map { |element| element.slice('name', 'id')}
  end

  def getTrelloCustomFields
    json = URI.open("https://api.trello.com/1/boards/#{params[:board_id]}/customFields?key=#{ENV['TRELLO_API_KEY']}&token=#{current_user.token}").read
    data = JSON.parse(json)
    ap data
    @trello_custom_fields = data.map { |element| element.slice('name', 'id')}
  end


  # def getTrelloRealTime
  #   url_board_custom_fields = "https://api.trello.com/1/boards/#{trello_board_id}/customFields?key=#{ENV['TRELLO_API_KEY']}&token=#{user.token}"
  #   json = URI.open(url_board_custom_fields).read
  #   data = JSON.parse(json)
  #   board_real_item = data.find { |item| item.where(name: "real time") }
  #   trello_real_time_id = board_real_item['id']
  #   url_card_custom_fields = "https://api.trello.com/1/cards/#{params[:card_id]}/customFieldItems?key=#{ENV['TRELLO_API_KEY']}&token=#{current_user.token}"
  #   json = URI.open(url_card_custom_fields).read
  #   data = JSON.parse(json)
  #   card_real_item = data.find { |fields| fields.where(idCustomField: trello_real_time_id ) }
  #   trello_real_time = minutes_to_hms(ard_real_item['value']['number'])
  # end

 #TODO jeudi
  def sendRealTimeToTrello
  end

  def minutes_to_hms(min)
    "#{min/60}h #{min % 60}min"
  end



end

  def project_params
    params.require(:project).permit(:name, :trello_board_id, :trello_list_id, :trello_done_list_id, :user_id, :trello_field_estimated_time_id, :trello_field_real_time_id )
  end
