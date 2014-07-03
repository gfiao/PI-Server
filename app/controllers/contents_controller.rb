class ContentsController < ApplicationController
  before_action :set_content, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]


  # GET /contents
  # GET /contents.json
  def index

    if !current_user.nil?
      temp = current_user.bookmarked_contents
      @user_bookmarked_contents = []

      temp.each do |entry|
        @user_bookmarked_contents.push(entry.content_id)
      end

    end

    if params[:user_id] # GET /users/:id/contents

      @search_only_user_contents = true
      @display_all = false

      if params[:tag]
        @selected_tag = params[:tag][:id]
        @contents = Tag.find(params[:tag][:id]).contents.where(:user_id => current_user.id)
      else
        @selected_tag = ""
        @contents = User.find(params[:user_id]).contents
      end

    else # GET /contents

      puts "============= /contents ============"

      @selected_tag = ""
      @contents = Content.all
      @display_all = true
      @search_only_user_contents = false

      if params[:tag]
        @selected_tag = params[:tag][:id]
        @contents = Tag.find(params[:tag][:id]).contents
      end

    end
  end


# GET /contents/1
# GET /contents/1.json
  def show
    if @content.nil?
      flash[:error] = "O conteúdo que procuras não existe!"
      redirect_to root_url
    else
      @latest = Content.all.order(created_at: :desc).limit(15)

      @author = User.find_by(:id => @content.user_id)
      # puts "LOOOOOOOOOOOOOOOOL"

      puts @content.title
      puts @author.id

      @video = @content.video

      if !(@content.views.nil?)
        @content.views = @content.views + 1
        @content.save
      end
    end
  end

# GET /contents/new
  def new
    @content = Content.new
    @tags = Tag.all
  end

# GET /contents/1/edit
  def edit

    if current_user.nil?
      flash[:error] = "Não tens permissões para realizar essa acção!"
      redirect_to root_url
    else
      if !@content.nil?
        if current_user.id == 1
          #modo admin, permitir edição
        elsif @content.user_id != current_user.id
          flash[:error] = "Não tens permissões para editar esse conteúdo!"
          redirect_to root_url
        end
      else
        flash[:error] = "O conteúdo que procuras não existe!"
        redirect_to root_url
      end
    end

  end

# POST /contents
# POST /contents.json
  def create
    @content = Content.new(content_params)
    @content.date = Date.today
    @content.user_id = current_user.id
    @content.views = 0
    @content.users << current_user

    if !params[:video].nil?
      Video.create(:link => params[:video][:link])
      @content.video = Video.find_by(:link => params[:video][:link])
    end

    params[:content][:tag_ids].each do |tag|
      if tag != ""
        @content.tags << Tag.find(tag)
      end

    end


    respond_to do |format|
      if @content.save
        format.html { redirect_to @content, notice: 'Content was successfully created.' }
        format.json { render :show, status: :created, location: @content }
      else
        format.html { render :new }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

# PATCH/PUT /contents/1
# PATCH/PUT /contents/1.json
  def update
    respond_to do |format|
      if @content.update(content_params)
        format.html { redirect_to @content, notice: 'Content was successfully updated.' }
        format.json { render :show, status: :ok, location: @content }
      else
        format.html { render :edit }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

# DELETE /contents/1
# DELETE /contents/1.json
  def destroy
    @content.destroy
    respond_to do |format|
      format.html { redirect_to contents_url, notice: 'Content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_content
    @user_id = -1
    if params[:title]
      @content = Content.where(title: params[:title]).first
    else
      # count = Content.count
      exists = Content.exists?(params[:id].to_i)
      if exists
        # puts ":::::::::::::::::::::::::::::::::::::"
        @content = Content.find(params[:id])
        @user_id = params[:user_id].to_i
      end
    end
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def content_params
    params.require(:content).permit(:title, :link_image, :description, :news_text, :link, tag_ids: [:id])
  end

end
