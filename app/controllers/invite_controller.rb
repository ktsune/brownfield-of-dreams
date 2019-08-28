# frozen_string_literal: true

class InviteController < ApplicationController
  def create
    email = GithubService.new(current_user).fetch_email(params[:handle])
    if email
      UserMailer.invite(current_user, params[:handle], email).deliver_now
      flash[:success] = "Sent an invite to #{params[:handle]}"
    else
      flash[:error] = "#{params[:handle]} doesn\'t have an email associated with their account."
    end
    redirect_to dashboard_path
  end
end
