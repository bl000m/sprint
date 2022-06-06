class User < ApplicationRecord
  has_many :projects
  has_many :tasks, primary_key: :trello_id, foreign_key: :trello_member_id, dependent: :destroy
  has_many :missions

  has_one :current_mission, -> { where(end_at: nil) }, class_name: 'Mission'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
