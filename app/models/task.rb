class Task < ApplicationRecord
  belongs_to :user, primary_key: :trello_id, foreign_key: :trello_member_id, optional: true
  belongs_to :project
  has_many :missions
  has_many :reviews

  def total_time_of_terminated_missions
    select_sql = <<~SQL
      *,
      extract(epoch from (end_at - created_at)) AS difference
    SQL
    if missions.where(end_at: nil)
      seconds_to_hms(missions.where.not(end_at: nil).select(select_sql).map(&:difference).sum)
    else
      seconds_to_hms(missions.where.not(end_at: nil).select(select_sql).map(&:difference).sum)
    end
  end

  def seconds_to_hms(sec)
    "%02d:%02d:%02d" % [sec / 3600, sec / 60 % 60, sec % 60]
  end
end
