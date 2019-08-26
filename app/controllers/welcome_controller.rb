class WelcomeController < ApplicationController
  def index
    if current_user
      if params[:tag]
        @tutorials = Tutorial.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
      else
        @tutorials = Tutorial.all.paginate(:page => params[:page], :per_page => 5)
      end
    else 
      if params[:tag]
        @tutorials = Tutorial.where(classroom: false).tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
      else
        @tutorials = Tutorial.where(classroom: false).paginate(:page => params[:page], :per_page => 5)
      end
    end
  end
end
