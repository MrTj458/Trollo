class TasksController < ApplicationController
before_action :set_list
before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = tasks.all
  end

  def show
  end

  def new
    @task = Task.new
    render partial: "edit"  
  end

  def edit
    render_partial: "edit"
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def create
    @task = tasks.new(tasks_params)
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def task_params
    params.require(:task).permit(:name)
  end


end
