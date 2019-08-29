# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    if current_user
      render locals: { facade: DashboardFacade.new(current_user) }
    else
      redirect_to login_path
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params.merge(uuid: SecureRandom.uuid))
    if user.save
      UserMailer.activate(user).deliver_now
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'That username is already in use.'
      render :new
    end
  end

  def update
    User.find_by(uuid: params[:uuid]).activate

    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
