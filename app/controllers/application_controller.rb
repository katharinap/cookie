class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    %i(sign_up sign_in account_update).each do |action|
      devise_parameter_sanitizer.for(action) << :name
      devise_parameter_sanitizer.for(action) << :email
    end
  end
end
