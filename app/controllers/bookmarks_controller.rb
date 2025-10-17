class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create]

  def new
    @bookmark = Bookmark.new
  end

  # def create
  #   @bookmark = Bookmark.new(bookmark_params)
  #   @bookmark.movie_id = params[:movie_id] if params[:movie_id].present?
  #   if @bookmark.save
  #     redirect_to @bookmark.list, notice: "Movie added!"
  #   else
  #     redirect_back fallback_location: movies_path, alert: "Could not add movie."
  #   end
  # end

  def create
  @list = List.find(params[:list_id])
  @bookmark = @list.bookmarks.new(bookmark_params)
  if @bookmark.save
    redirect_to list_path(@list), notice: "Movie added to the list!"
  else
    render :new, status: :unprocessable_entity
  end
end

  # def create
  #   @bookmark = @list.bookmarks.build(bookmark_params)
  #   if @bookmark.save
  #     redirect_to list_path(@list), notice: "Bookmark was successfully added."
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = @bookmark.list
    @bookmark.destroy
    redirect_to list_path(@list), notice: "Bookmark was successfully deleted."
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end



end
