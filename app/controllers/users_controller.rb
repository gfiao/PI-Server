class UsersController < ApplicationController

  #Corre a função set_user antes das chamadas a show, edit...
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index

    if user_signed_in?
      if current_user.id == 1
        @users = User.all
      end
    else
      flash[:error] = "Não tens permissões para realizar tal acção!"
      redirect_to root_url
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show

    if @user.nil?
      flash[:error] = "O utilizador que procuras não existe!"
      redirect_to root_url
    end

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if current_user.nil?
      flash[:error] = "Não tens permissões para realizar essa acção!"
      redirect_to root_url
    else
      if params[:id].to_i == current_user.id
        redirect_to edit_user_registration_path
      elsif current_user.id == 1
        #é o admin, ele pode editar!
      else
        flash[:error] = "Não tens permissões para editar esse utilizador!"
        redirect_to root_url
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    if params[:name]
      @user = User.where(name: params[:name]).first
    else
      count = User.count
      if params[:id].to_i <= count
        @user = User.find(params[:id])
      end
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :birth_date, :gender, :course, :about_me, :avatar_url)
  end
end
