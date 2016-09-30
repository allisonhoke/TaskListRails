class TasksController < ApplicationController

  def index
    @all_the_tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
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
    puts @task.id

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
