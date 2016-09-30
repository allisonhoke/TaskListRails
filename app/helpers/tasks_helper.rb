module TasksHelper
  def completion_status(task)
    if task.is_complete?
      "YES!"
    else
      "No!"
    end
  end
end
