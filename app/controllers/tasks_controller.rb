class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.find(task_id)

    if @task.nil?
      head :not_found
    end
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(
      name: params[:task][:name],
      description: params[:task][:description]
    )

    if task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find_by(id: params[:id].to_i)

    if @task.nil?
      head :not_found
    end
  end

  def update

    @task = Task.find_by(id: params[:id].to_i)

    @task.update(
      name: params[:task][:name],
      description: params[:task][:description]
    )

    if @task.save
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def complete
    @task = Task.find_by(id: params[:id].to_i)

    @task.update(
      completion_date: (Time.now).to_s
    )

    if @task.save
      redirect_to tasks_path
    end
  end

  def uncomplete
    @task = Task.find_by(id: params[:id].to_i)

    @task.update(
      completion_date: nil
    )

    if @task.save
      redirect_to tasks_path
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id].to_i)

    if @task.destroy
      redirect_to tasks_path
    else
      head :not_found
    end
  end
end
