# frozen_string_literal: true

class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def self.classroom?(user_exists)
    if !user_exists
      where(classroom: false)
    else
      all
    end
  end
end
