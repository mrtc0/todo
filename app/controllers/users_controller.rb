class UsersController < ApplicationController
  include Session

  skip_before_action :require_logged_in!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    if user_params[:password] != user_params[:password_confirm]
      @user = User.new(email: user_params[:email])
      @user.errors.add(:user, t('view.user.message.missmatch_password'))
      render :new and return
    end

    @user = User.new(email: user_params[:email], password: user_params[:password])
    if @user.save
      # ログイン画面へ遷移、アカウント登録が完了しましたという通知も出す
      redirect_to login_path, flash: { success: t('view.user.message.registration_successful') }
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirm)
  end
end
