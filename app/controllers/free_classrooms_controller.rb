class FreeClassroomsController < ApplicationController
  before_action :set_free_classroom, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]

  # GET /free_classrooms
  # GET /free_classrooms.json
  def index
    # @free_classrooms = FreeClassroom.alls
    if params[:classroom]
      @selected_building = params[:classroom][:building]
      if params[:classroom][:building] != ""
        classrooms = Classroom.where(:building => params[:classroom][:building])
        @free_classrooms = FreeClassroom.where(:classroom_id => classrooms)
      else
        @free_classrooms = FreeClassroom.all
      end
    else
      @free_classrooms = FreeClassroom.all
    end


  end

  # GET /free_classrooms/1
  # GET /free_classrooms/1.json
  def show

    # apenas o administrador pode ver/editar
    if @free_classroom.nil?
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

  # GET /free_classrooms/new
  def new
    @free_classroom = FreeClassroom.new
  end

  # GET /free_classrooms/1/edit
  def edit

    # dar permissão ao administrador para alterar????
    redirect_to root_url
  end

  # POST /free_classrooms
  # POST /free_classrooms.json
  def create
    @free_classroom = FreeClassroom.new(free_classroom_params)
    @free_classroom.user_id = current_user.id

    # puts "======================================"
    # puts params[:from_time]
    # puts "======================================"

    # @free_classroom.from_time = @free_classroom.from_time.change(day: Date.today.day)
    # @free_classroom.from_time = Date.today

    @free_classroom.to_time = @free_classroom.to_time.change(day: Date.today.day)

    respond_to do |format|
      if @free_classroom.save
        format.html { redirect_to free_classrooms_path, notice: 'Free classroom was successfully created.' }
        format.json { render :show, status: :created, location: @free_classroom }
      else
        format.html { render :new }
        format.json { render json: @free_classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /free_classrooms/1
  # PATCH/PUT /free_classrooms/1.json
  def update


    respond_to do |format|
      if @free_classroom.update(free_classroom_params)
        format.html { redirect_to free_classrooms_path, notice: 'Free classroom was successfully updated.' }
        format.json { render :show, status: :ok, location: @free_classroom }
      else
        format.html { render :edit }
        format.json { render json: @free_classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /free_classrooms/1
  # DELETE /free_classrooms/1.json
  def destroy
    @free_classroom.destroy
    respond_to do |format|
      format.html { redirect_to free_classrooms_url, notice: 'Free classroom was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_free_classroom
    count = FreeClassroom.count
    if params[:id].to_i <= count
      @free_classroom = FreeClassroom.find(params[:id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def free_classroom_params
    #params.require(:free_classroom).permit(:user_id, :classroom_id, :time)
    params.require(:free_classroom).permit(:classroom_id, :from_time, :to_time, :likes)

  end
end
