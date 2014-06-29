class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :update, :destroy]

  # GET /scores
  # GET /scores.json
  def index

    if user_signed_in?
      @scores = current_user.scores
    else
      @scores = Score.all
    end
  end

  # GET /scores/1
  # GET /scores/1.json
  def show

    # apenas o administrador pode ver/editar
    if @score.nil?
      flash[:error] = "Esse conteúdo não existe!"
      redirect_to root_url
    else
      if current_user.nil?
        flash[:error] = "Não tens permissões para realizar esta acção!"
        redirect_to root_url
      else
        if current_user.id != 1
          flash[:error] = "Não tens permissões para visualizar este conteúdo!"
          redirect_to root_url
        end
      end
    end

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

    if user_signed_in?
      @score = Score.new(:user_id => current_user.id, :game_id => params[:game_id], :score => params[:score])
      @score.save

      if !@score.save
        updScore = Score.find_by(user_id: current_user.id)
        if updScore.score < params[:score].to_i
          updScore.score = params[:score]
          updScore.save
        end
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
    count = Score.count
    if params[:id].to_i <= count
      @score = Score.find(params[:id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def score_params
    params.require(:score).permit(:user_id, :game_id, :score)
  end
end
