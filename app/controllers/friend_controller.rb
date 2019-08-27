# frozen_string_literal: true

class FriendController < ApplicationController
  def create
    friend = User.find_by(uid: params[:uid])
    Friendship.create!(user_id: current_user.id, friend_id: friend.id)
    redirect_to dashboard_path
  end
end
