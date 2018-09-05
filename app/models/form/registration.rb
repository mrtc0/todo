# app/models/form/registration.rb
class Form::Registration
  include ActiveModel::Model

  attr_accessor :email, :password, :password_confirmation

  validates_confirmation_of :password,
    message: I18n.t('view.user.message.missmatch_password')

  def valid?
    result = super

    user = User.new(email: email, password: password)
    # Userモデルのバリデーションエラーとマージする
    unless user.valid?
      user.errors.each do |k, v|
        errors.add(k, v)
      end
      return false
    end
    result
  end

  def save
    User.create(email: email, password: password)
  end
end
