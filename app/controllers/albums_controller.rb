class AlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @albums = current_user.albums
    @q = @albums.ransack(params[:q])
    @albums = @q.result.includes(:tags)
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    # @album = Album.new
    @album = current_user.albums.build
  end

  def create
    # @album = current_user.albums.new(album_params)
    @album = current_user.albums.build(album_params)

    if @album.save
      redirect_to @album
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to @album
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    redirect_to root_path, status: :see_other
  end
  
  

  def correct_user
    @album = current_user.albums.find_by(id: params[:id])
    redirect_to root_path, alert: "You are not authorized" if @album.nil?
  end


  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end


  def purge
    attachment = ActiveStorage::Attachment.find(params[:id])
    attachment.purge
    redirect_to fallback_location: root_path, notice: "Image deleted"
  end



  private
    def album_params
      params.require(:album).permit(:title, :description, :all_tags, :published, :cover_image, :images => [])
    end
end
