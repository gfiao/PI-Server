class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :update, :destroy]

  # GET /scores
  # GET /scores.json
  def index
    @scores = Score.all

  end

  # GET /scores/1
  # GET /scores/1.json
  def show
  end

  # GET /scores/new
  def new
    @score = Score.new
  end

  # GET /scores/1/edit
  def edit
  end

  # POST /scores
  # POST /scores.json
  def create
    # @score = Score.new(score_params)

    @score = Score.new(:user_id => params[:user_id], :game_id => params[:game_id], :score => params[:score])
    @score.save

    if @score.save
    else
      updScore = Score.find_by(user_id: params[:user_id])
      if updScore.score < params[:score].to_i
        updScore.score = params[:score]
        updScore.save
      end
    end

    respond_to do |format|
      if @score.save
        format.html { redirect_to @score, notice: 'Score was successfully created.' }
        format.json { render :show, status: :created, location: @score }
      else
        format.html { render :new }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scores/1
  # PATCH/PUT /scores/1.json
  def update
    respond_to do |format|
      if @score.update(score_params)
        format.html { redirect_to @score, notice: 'Score was successfully updated.' }
        format.json { render :show, status: :ok, location: @score }
      else
        format.html { render :edit }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1
  # DELETE /scores/1.json
  def destroy
    @score.destroy
    respond_to do |format|
      format.html { redirect_to scores_url, notice: 'Score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_score
    @score = Score.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def score_params
    params.require(:score).permit(:user_id, :game_id, :score)
  end
end
