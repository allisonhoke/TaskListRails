class Task < ActiveRecord::Base
  def is_complete?
    completed_at != nil
  end

  def mark_complete
    self.completed_at = Time.now
  end
end
