class TaskController < ApplicationController
  def index
    @tasks = TASKS
  end
end
