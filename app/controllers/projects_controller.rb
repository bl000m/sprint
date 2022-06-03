require 'open-uri'

class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def create
    @projects = Project.new(project_params)
    if @projects.save
      redirect_to new_projects_url
    else
      render "projects/new"
    end
  end

  def new_boards
    getTrelloBoards
    render partial: 'new_boards', locals: {boards: @boards}
  end

  def form
    getTrelloLists
    project = Project.new(name: params[:name], trello_board_id: params[:board_id])
    render partial: 'form', locals: {project: project, trello_lists: @trello_lists}
  end

  private

  def getTrelloBoards
    json = URI.open("https://api.trello.com/1/members/me/boards?key=#{ENV['TRELLO_API_KEY']}&token=#{current_user.token}").read
    data = JSON.parse(json)
    @boards = data.map { |element| element.slice('name', 'id')}
  end

  def getTrelloLists
    json = URI.open("https://api.trello.com/1/boards/#{params[:board_id]}/lists?key=#{ENV['TRELLO_API_KEY']}&token=#{current_user.token}").read
    data = JSON.parse(json)
    ap data
    @trello_lists = data.map { |element| element.slice('name', 'id')}
  end
end

  def project_params
    params.require(:project).permit(:name, :trello_board_id, :trello_list_id, :trello_done_list_id, :user_id )
  end

# <%
#   trello_lists = [
#     {"name" => "aaa", "id" => "zedfihb"},
#     {"name" => "bbb", "id" => "zd"},
#     {"name" => "ccc", "id" => "zdfzef"}
#   ]
# %>

# <%= render 'form', project: Project.new(name: 'toto'), trello_lists: trello_lists %>
