class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = get_id

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
    @task = get_id
  end

  def update

    @task = get_id

    @task.update(task_params)
    redirect_to tasks_path
  end

  def complete
    @task = get_id

    @task.update(
      completion_date: (Time.now).to_s
    )
    redirect_to tasks_path
  end

  def uncomplete
    @task = get_id

    @task.update(
      completion_date: nil
    )
    redirect_to tasks_path
  end

  def destroy
    @task = get_id

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

  def get_id
    return Task.find_by(id: params[:id].to_i)
  end
end
