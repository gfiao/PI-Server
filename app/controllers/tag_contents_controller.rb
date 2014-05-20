class TagContentsController < ApplicationController
  before_action :set_tag_content, only: [:show, :edit, :update, :destroy]

  # GET /tag_contents
  # GET /tag_contents.json
  def index
    @tag_contents = TagContent.all
  end

  # GET /tag_contents/1
  # GET /tag_contents/1.json
  def show
  end

  # GET /tag_contents/new
  def new
    @tag_content = TagContent.new
  end

  # GET /tag_contents/1/edit
  def edit
  end

  # POST /tag_contents
  # POST /tag_contents.json
  def create
    @tag_content = TagContent.new(tag_content_params)

    respond_to do |format|
      if @tag_content.save
        format.html { redirect_to @tag_content, notice: 'Tag content was successfully created.' }
        format.json { render :show, status: :created, location: @tag_content }
      else
        format.html { render :new }
        format.json { render json: @tag_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tag_contents/1
  # PATCH/PUT /tag_contents/1.json
  def update
    respond_to do |format|
      if @tag_content.update(tag_content_params)
        format.html { redirect_to @tag_content, notice: 'Tag content was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag_content }
      else
        format.html { render :edit }
        format.json { render json: @tag_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag_contents/1
  # DELETE /tag_contents/1.json
  def destroy
    @tag_content.destroy
    respond_to do |format|
      format.html { redirect_to tag_contents_url, notice: 'Tag content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag_content
      @tag_content = TagContent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_content_params
      params.require(:tag_content).permit(:content_id, :tag_id)
    end
end
