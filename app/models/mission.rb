class Mission < ApplicationRecord
  belongs_to :task
  belongs_to :user

  after_create :stop_others

  def pause!
    update(end_at: Time.now)
  end

  private

  def stop_others
    user.missions.where(end_at: nil).where.not(id: id).update_all(end_at: Time.now)
  end
end
