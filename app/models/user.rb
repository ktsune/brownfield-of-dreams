# frozen_string_literal: true

require 'securerandom'

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def activate
    update_attribute(:activated, true)
  end

  def connect(data)
    self.attributes = {
      uid: data.uid.id.to_s,
      handle: data.info.nickname,
      token: data.credentials.token
    }
    # binding.pry
    save
  end

  def ordered_tutorials
    Tutorial.includes(videos: :user_videos)
            .where(user_videos: { user_id: id })
            .order('videos.position asc')
  end
end
