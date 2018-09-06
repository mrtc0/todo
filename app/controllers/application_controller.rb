class ApplicationController < ActionController::Base
  include Session
  include SessionHelper

  before_action :set_locale
  before_action :require_logged_in!

  private

    def set_locale
      I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
    end
end
