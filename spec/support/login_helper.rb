module LoginHelper
  def login_as(user)
    page.set_rack_session(user_id: user.id)
  end

  def login(user)
    request.session[:user_id] = user.id
  end
end
