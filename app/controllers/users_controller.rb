# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
    @user_count = User.count
  end

  def create
  end
end
