# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    render locals: { facade: DashboardFacade.new(current_user) }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      UserMailer.activate(user).deliver_now
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    User.find(params[:user_id]).activate

    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
