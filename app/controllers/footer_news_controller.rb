class FooterNewsController < ApplicationController
  before_action :set_footer_news, only: [:show, :edit, :update, :destroy]

  # GET /footer_news
  # GET /footer_news.json
  def index
    @footer_news = FooterNews.all
  end

  # GET /footer_news/1
  # GET /footer_news/1.json
  def show
  end

  # GET /footer_news/new
  def new
    @footer_news = FooterNews.new
  end

  # GET /footer_news/1/edit
  def edit
  end

  # POST /footer_news
  # POST /footer_news.json
  def create
    @footer_news = FooterNews.new(footer_news_params)

    respond_to do |format|
      if @footer_news.save
        format.html { redirect_to @footer_news, notice: 'Footer news was successfully created.' }
        format.json { render :show, status: :created, location: @footer_news }
      else
        format.html { render :new }
        format.json { render json: @footer_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /footer_news/1
  # PATCH/PUT /footer_news/1.json
  def update
    respond_to do |format|
      if @footer_news.update(footer_news_params)
        format.html { redirect_to @footer_news, notice: 'Footer news was successfully updated.' }
        format.json { render :show, status: :ok, location: @footer_news }
      else
        format.html { render :edit }
        format.json { render json: @footer_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /footer_news/1
  # DELETE /footer_news/1.json
  def destroy
    @footer_news.destroy
    respond_to do |format|
      format.html { redirect_to footer_news_index_url, notice: 'Footer news was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_footer_news
      @footer_news = FooterNews.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def footer_news_params
      params.require(:footer_news).permit(:category, :news, :date)
    end
end
