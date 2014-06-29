class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    if user_signed_in?
      if current_user.id == 1 #Modo administrador
        @games = Game.all
      else
        @games = Game.find_by(id: 1)
        redirect_to :action => "show", :id => 1
      end
    else
      @games = Game.find_by(id: 1)
      redirect_to :action => "show", :id => 1
    end

  end

  # GET /games/1
  # GET /games/1.json
  def show

    if @game.nil?
      @games = Game.find_by(id: 1)
      redirect_to :action => "show", :id => 1
    else
      if params[:id].to_i == 1 #De momento só temos o 2048, alterar esta merda caso haja mais jogos
        @highest_scores_by_course = Score.find_by_sql("SELECT users.name, course, score FROM scores INNER JOIN users ON scores.user_id = users.id INNER JOIN games ON scores.game_id = games.id GROUP BY users.course ORDER BY MAX(score) DESC")
        puts "======================="
        @highest_scores_by_course.each do |s|
          puts "#{s.course} - #{s.name} - #{s.score}"
        end
        # puts x
        puts "======================="
      else
        @games = Game.find_by(id: 1)
        redirect_to :action => "show", :id => 1
      end
    end
  end

  # GET /games/new
  def new

    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_game
    count = Game.count
    if params[:id].to_i <= count
      @game = Game.find(params[:id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def game_params
    params.require(:game).permit(:name)
  end
end
