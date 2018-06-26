# タスクの一覧、作成、更新、削除
class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order(created_at: 'DESC')
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, flash: { success: 'タスクを作成しました' } }
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
        format.html { redirect_to @task, flash: { success: '更新しました' } }
      else
        # TODO: エラー処理を書く
        format.html { render :edit }
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, flash: { success: 'タスクを削除しました' } }
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
