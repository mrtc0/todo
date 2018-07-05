# タスクの一覧、作成、更新、削除
class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = if params[:sort] == 'expire'
               Task.order(expire_at: 'ASC')
                   .search_by_title_and_status(params)
             else
               Task.order(created_at: 'DESC')
                   .search_by_title_and_status(params)
             end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, flash: { success: t('view.task.message.created') } }
      else
        # TODO: エラー処理を書く
        format.html { render :new }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, flash: { success: t('view.task.message.updated') } }
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
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :expire_at, :priority)
    end
end
