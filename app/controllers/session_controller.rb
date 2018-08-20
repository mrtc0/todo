class SessionController < ApplicationController
  include Session

  skip_before_action :require_logged_in!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: credential_params[:email])

    respond_to do |format|
      if @user && @user.authenticate(credential_params[:password])
        login(@user)
        format.html { redirect_to tasks_path, flash: { success: t('view.session.message.login_successful') } }
      else
        flash.now[:danger] = t('view.session.message.login_failed')
        format.html { render :new }
      end
    end
  end

  def destroy
    logout
    redirect_to login_path
  end

  private

    def credential_params
      params.require(:user).permit(:email, :password)
    end
end
