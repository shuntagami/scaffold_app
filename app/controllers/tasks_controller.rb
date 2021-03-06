class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :search_task, only: [:index, :search]

  def index
    @tasks = current_user.tasks.recent
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
  end

  def search
    @results = @q.result(distinct: true)
  end

  def priority
    @priority_tasks = current_user.tasks.priority
  end

  def to_do
    @to_do_tasks = current_user.tasks.to_do
  end

  def in_progress
    @in_progress_tasks = current_user.tasks.in_progress
  end

  def done
    @done_tasks = current_user.tasks.done
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :deadline, :completed)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def search_task
    @q = current_user.tasks.ransack(params[:q])
  end
end
