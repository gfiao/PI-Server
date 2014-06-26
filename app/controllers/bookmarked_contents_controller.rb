class BookmarkedContentsController < ApplicationController
  before_action :set_bookmarked_content, only: [:show, :edit, :update, :destroy]

  # GET /bookmarked_contents
  # GET /bookmarked_contents.json
  def index
    @bookmarked_contents = BookmarkedContent.all
  end

  # GET /bookmarked_contents/1
  # GET /bookmarked_contents/1.json
  def show
  end

  # GET /bookmarked_contents/new
  def new
    @bookmarked_content = BookmarkedContent.new
  end

  # GET /bookmarked_contents/1/edit
  def edit
  end

  # POST /bookmarked_contents
  # POST /bookmarked_contents.json
  def create
    @bookmarked_content = BookmarkedContent.new
    @bookmarked_content.content_id = params[:content_id]
    @bookmarked_content.user_id = current_user.id

    puts @bookmarked_content

    respond_to do |format|
      if @bookmarked_content.save
        format.html { redirect_to @bookmarked_content, notice: 'Bookmarked content was successfully created.' }
        format.json { render :show, status: :created, location: @bookmarked_content }
      else
        format.html { render :new }
        format.json { render json: @bookmarked_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookmarked_contents/1
  # PATCH/PUT /bookmarked_contents/1.json
  def update
    respond_to do |format|
      if @bookmarked_content.update(bookmarked_content_params)
        format.html { redirect_to @bookmarked_content, notice: 'Bookmarked content was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookmarked_content }
      else
        format.html { render :edit }
        format.json { render json: @bookmarked_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarked_contents/1
  # DELETE /bookmarked_contents/1.json
  def destroy
    @bookmarked_content.destroy
    respond_to do |format|
      # format.html { redirect_to user_path, notice: 'Bookmarked content was successfully destroyed.' }
      format.html { redirect_to bookmarked_contents_url, notice: 'Bookmarked content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmarked_content
      @bookmarked_content = BookmarkedContent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmarked_content_params
      params.require(:bookmarked_content).permit(:content_id)
    end
end
