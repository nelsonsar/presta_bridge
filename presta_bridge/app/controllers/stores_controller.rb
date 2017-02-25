class StoresController < ApplicationController
  layout 'user'

  before_action :authorize

  def new;end

  def create
    store = build_store

    if store.save
      redirect_to settings_path
    else
      flash[:error] = store.errors.full_messages
      redirect_to new_user_store_path(current_user)
    end
  end

  def destroy
    if current_user.store.id == params[:id].to_i
      current_user.store.destroy
    end

    redirect_to settings_path
  end

  private

  def store_params
    params.require(:store)
          .permit(
            :name,
            :url,
            :api_key
          )
  end

  def build_store
    current_user.build_store store_params
  end

  def owned_by_current_user?

  end
end
