# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
    @user_count = User.count
    session.delete(:user_id)
  end

  def create
    user = User.find_or_create_by(user_params)
    session[:user_id] = user.id
    redirect_to session[:user_return_to]
  end

  private

  def user_params
    params.require(:user).permit(:blockfolio_token)
  end
end
