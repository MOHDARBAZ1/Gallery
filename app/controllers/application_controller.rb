class ApplicationController < ActionController::Base

  def set_search
    @q=Album.search(params[:q])
  end
    
end
