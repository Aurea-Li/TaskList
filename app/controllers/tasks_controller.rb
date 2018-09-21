class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = find_task

    if @task.nil?
      head :not_found
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)

    if task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @task = find_task
  end

  def update

    @task = find_task

    #TODO: error checking
    @task.update(task_params)
    redirect_to tasks_path
  end

  def complete
    @task = find_task

    @task.update(
      completion_date: (Time.now).to_s
    )
    redirect_to tasks_path
  end

  def uncomplete
    @task = find_task

    @task.update(
      completion_date: nil
    )
    redirect_to tasks_path
  end

  def destroy
    @task = find_task

    @task.destroy
    redirect_to tasks_path
  end

  private

  def task_params
    return params.require(:task).permit(
      :name,
      :description
    )
  end

  def find_task
    return Task.find_by(id: params[:id].to_i)
  end
end
