class WelcomeController < ApplicationController
  def index
    if params[:tag]
      @tutorials = Tutorial.classroom?(current_user).tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
    else
      @tutorials = Tutorial.classroom?(current_user).paginate(:page => params[:page], :per_page => 5)
    end
  end
end
