# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :active_user?

  def active_user?
    if current_user.present? && !current_user.active?
      sign_out(current_user)
      redirect_to(new_user_session_path,
                  alert: 'Seu usuário está inativo. Para mais informações, entre em contato com o administrador do sistema.')
    end
  end
end
