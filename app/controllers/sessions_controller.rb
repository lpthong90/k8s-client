# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    sign_in_and_redirect user, event: :authentication
    set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
  end

  def destroy
    sign_out_and_redirect(current_user)
    set_flash_message(:notice, :signed_out) if is_navigational_format?
  end

  def failure
    redirect_to root_path, alert: 'Authentication failed, please try again.'
  end
end
