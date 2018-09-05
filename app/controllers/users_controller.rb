class UsersController < ApplicationController
  include Session

  skip_before_action :require_logged_in!, only: [:new, :create]

  def new
    @registration = Form::Registration.new
  end

  def create
    @registration = Form::Registration.new(registration_params)
    if @registration.valid?
      # ログイン画面へ遷移、アカウント登録が完了しましたという通知も出す
      @registration.save
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

    def registration_params
      params.require(:form_registration).permit(:email, :password, :password_confirmation)
    end
end
