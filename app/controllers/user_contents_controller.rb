class UserContentsController < ApplicationController
  before_action :set_user_content, only: [:show, :edit, :update, :destroy]

  # GET /user_contents
  # GET /user_contents.json
  def index
    if user_signed_in?
      @user_contents = current_user.user_contents
    else
      @user_contents = UserContent.all
    end

  end

  # GET /user_contents/1
  # GET /user_contents/1.json
  def show
  end

  # GET /user_contents/new
  def new
    @user_content = UserContent.new
  end

  # GET /user_contents/1/edit
  def edit
  end

  # POST /user_contents
  # POST /user_contents.json
  def create
    @user_content = UserContent.new(user_content_params)

    respond_to do |format|
      if @user_content.save
        format.html { redirect_to @user_content, notice: 'User content was successfully created.' }
        format.json { render :show, status: :created, location: @user_content }
      else
        format.html { render :new }
        format.json { render json: @user_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_contents/1
  # PATCH/PUT /user_contents/1.json
  def update
    respond_to do |format|
      if @user_content.update(user_content_params)
        format.html { redirect_to @user_content, notice: 'User content was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_content }
      else
        format.html { render :edit }
        format.json { render json: @user_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_contents/1
  # DELETE /user_contents/1.json
  def destroy
    @user_content.destroy
    respond_to do |format|
      format.html { redirect_to user_contents_url, notice: 'User content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_content
      @user_content = UserContent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_content_params
      params.require(:user_content).permit(:user_id, :content_id)
    end
end
