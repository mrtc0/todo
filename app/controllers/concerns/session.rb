module Session
  extend ActiveSupport::Concern

  def login(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  def require_logged_in!
    redirect_to login_path unless logged_in?
  end

  def require_admin!
    # TODO: ちゃんと 404 を返すものを作る
    render file: "#{Rails.root}/public/404", status: :not_found unless @current_user&.admin?
  end
end
