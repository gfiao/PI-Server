class CurrentVideosController < ApplicationController
  before_action :set_current_video, only: [:show, :edit, :update, :destroy]

  # GET /current_videos
  # GET /current_videos.json
  def index
    @current_videos = CurrentVideo.all
  end

  # GET /current_videos/1
  # GET /current_videos/1.json
  def show
  end

  # GET /current_videos/new
  def new
    @current_video = CurrentVideo.new
  end

  # GET /current_videos/1/edit
  def edit
  end

  # POST /current_videos
  # POST /current_videos.json
  def create
    @current_video = CurrentVideo.new(current_video_params)

    respond_to do |format|
      if @current_video.save
        format.html { redirect_to @current_video, notice: 'Current video was successfully created.' }
        format.json { render :show, status: :created, location: @current_video }
      else
        format.html { render :new }
        format.json { render json: @current_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /current_videos/1
  # PATCH/PUT /current_videos/1.json
  def update
    respond_to do |format|
      if @current_video.update(current_video_params)
        format.html { redirect_to @current_video, notice: 'Current video was successfully updated.' }
        format.json { render :show, status: :ok, location: @current_video }
      else
        format.html { render :edit }
        format.json { render json: @current_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /current_videos/1
  # DELETE /current_videos/1.json
  def destroy
    @current_video.destroy
    respond_to do |format|
      format.html { redirect_to current_videos_url, notice: 'Current video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_video
      @current_video = CurrentVideo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def current_video_params
      params.require(:current_video).permit(:index)
    end
end
