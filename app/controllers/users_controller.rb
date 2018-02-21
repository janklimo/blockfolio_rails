# frozen_string_literal: true

class UsersController < ApplicationController
  layout 'doorkeeper/application'

  def new
    @user = User.new
    @user_count = User.count
    session.delete(:user_id)
  end

  def create
    if (token = user_params['blockfolio_token']).blank?
      flash[:alert] = "Please insert your Blockfolio Token"
      redirect_to root_url
      return
    end

    validator = BlockfolioToken.new(token)

    if validator.valid?
      user = User.find_or_create_by(user_params)
      session[:user_id] = user.id
      redirect_to session[:user_return_to]
    else
      flash[:alert] = "That doesn't seem to be a valid Blockfolio Token"
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:blockfolio_token)
  end
end
