# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @tutorials = if params[:tag]
                   Tutorial.classroom?(current_user).tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
                 else
                   Tutorial.classroom?(current_user).paginate(page: params[:page], per_page: 5)
                 end
  end
end
