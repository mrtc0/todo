class Admin::UsersController < ApplicationController
  before_action :require_admin!, only: [:index, :new, :edit, :update, :destory]
  before_action :set_user, only: [:update]

  def index
    @users = User.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, flash: { success: t('view.user.message.updated') }
    end
  end

  def destroy
  end

  private

    def set_user
      @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:email)
    end
end
