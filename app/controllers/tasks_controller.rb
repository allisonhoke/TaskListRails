class TasksController < ApplicationController
  def index
    @all_the_tasks = @current_user.tasks
  end

  def show
    @task = Task.find_by(user_id: @current_user.id, id: params[:id])
    # Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = @current_user.id
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find_by(user_id: @current_user.id, id: params[:id])
  end

  def update
    @task = Task.find_by(user_id: @current_user.id, id: params[:id])
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def complete
    @task = Task.find(params[:id])
    @task.mark_complete
    @task.save

    redirect_to task_path
  end

  def destroy
    @task = Task.find(params[:id]).destroy

    redirect_to tasks_path
  end

  private

  def task_params
    puts ">>>>> DPR: #{params}"
    params.require(:task).permit(:title, :description, :completed_at)
  end
end
