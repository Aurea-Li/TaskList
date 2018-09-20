class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    task_id = params[:id].to_i
    @task = Task.all[task_id]

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
    task_id = params[:id].to_i
    @task = Task.find_by(id: task_id)

    if @task.nil?
      head :not_found
    end
  end

  def update
    name = params[:task][:name]
    description = params[:task][:description]

    if name && description
      @task.update(name: name, description: description)
    elsif name
      @task.update(name: name)
    elsif description
      @task.update(description: description)
    else
      head :no_content
    end

    @task.save
  end
end
