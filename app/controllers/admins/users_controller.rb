# frozen_string_literal: true

module Admins
  class UsersController < ApplicationController
    before_action :user, only: [:edit, :update]
    before_action :verify_password, only: [:update]

    def index
      @users = User.all
    end

    def new
      @user = User.new

      @user.build_person
      @user.person.build_address
    end

    def create
      @user = User.new(user_params)

      if @user.save
        redirect_success(path: admins_users_path, action: 'criado(a)')
      else
        render(:new, status: :unprocessable_entity)
      end
    end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_success(path: admins_users_path, action: 'atualizado(a)')
      else
        render(:edit, status: :unprocessable_entity)
      end
    end

    private

    def user_params
      params.require(:user)
            .permit(User.permitted_params,
                    person_attributes: [
                      Person.permitted_params,
                      { address_attributes: Address.permitted_params }
                    ])
    end

    def redirect_success(path:, action:)
      redirect_to(path)
      flash[:success] = "Usuário(a) #{action} com sucesso."
    end

    def user
      @user = User.find(params[:id])
    end

    def verify_password
      if params[:user].present? && (params[:user][:password].blank? && params[:user][:password_confirmation].blank?)
        params[:user].extract!(:password, :password_confirmation)
      end
    end
  end
end
