class UsersController < ApplicationController
  before_action :authorize, only: :settings

  def new; end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to settings_path
    else
      flash[:error] = user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def settings
    @store = current_user.store
    render layout: 'user'
  end

  private

  def user_params
    params.require(:user)
          .permit(
            :name,
            :email,
            :password,
            :password_confirmation
          )
  end
end
