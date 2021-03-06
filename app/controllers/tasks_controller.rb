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
    
  end

  def edit
    
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def create
    @task = @list.tasks.new(task_params)
    
    if @task.save
      redirect_to board_list_path(@list.board, @list)
    else
      render :new
    end
  end

  def destroy
    @task.destroy
    redirect_to board_list_path(@list.board, @list)
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def task_params
    params.require(:task).permit(:task)
  end


end
