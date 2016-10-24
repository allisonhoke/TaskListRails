class Task < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true

  def is_complete?
    completed_at != nil
  end

  def mark_complete
    self.completed_at = Time.now
  end
end
