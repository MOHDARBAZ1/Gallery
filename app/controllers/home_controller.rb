class HomeController < ApplicationController

  def index
    if user_signed_in?
      redirect_to albums_path
    else
    @albums = Album.where(published: true)
    end
    

       
    if params[:tag]
      @albums = Album.tagged_with(params[:tag])
    else
      @albums = Album.where(published: true)
    end


    @q = Album.where(published: true).ransack(params[:q])
    @albums = @q.result.includes(:tags)
  end

  def show
    @album = Album.find(params[:id])
  end

  

end
