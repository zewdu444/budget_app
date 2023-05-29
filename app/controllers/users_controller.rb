class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    if params[:id] == 'sign_out'
      sign_out_and_redirect
    else
      find_user
    end
  end

  private

  def sign_out_and_redirect
    sign_out current_user
    redirect_to splash_path
  end

  def find_user
    @user = User.find_by(id: params[:id])
    redirect_to users_path, alert: 'User not found' unless @user
  end
end
