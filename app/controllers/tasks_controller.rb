# タスクの一覧、作成、更新、削除
class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_priority, only: [:index]

  def index
    @tasks = @current_tasks.filter_by_title_and_status(params)
    @statuses = Task.statuses
    # N+1 の確認用なので消す
    @all_tasks = Task.all
  end

  def new
    @task = Task.new
    @priorities = Task.priorities
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, flash: { success: t('view.task.message.created') } }
      else
        # TODO: エラー処理を書く
        @priorities = Task.priorities
        format.html { render :new }
      end
    end
  end

  def show
  end

  def edit
    @statuses = Task.statuses
    @priorities = Task.priorities
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, flash: { success: t('view.task.message.updated') } }
      else
        # TODO: エラー処理を書く
        format.html { render :edit }
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, flash: { success: t('view.task.message.deleted') } }
    end
  end

  private

    def set_task
      @task = Task.find_by(id: params[:id], user: current_user)
    end

    def task_params
      params.require(:task).permit(:title, :description, :expire_at, :priority)
    end

    def set_priority
      if params[:priority]
        @current_tasks = current_user.tasks.page(params[:page]).sort_by_priority(params[:priority])
      else
        @current_tasks = current_user.tasks.page(params[:page])
      end
    end
end
