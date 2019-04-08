class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    super
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) {
      |u| u.permit(
        :email,
        :phone_numbers,
        :address,
        :first_name,
        :last_name,
        :password,
        :password_confirmation
      )
    }

    devise_parameter_sanitizer.permit(:sign_in) {
      |u| u.permit(
        :email,
        :password,
        :remember_me
      )
    }
  end

end
