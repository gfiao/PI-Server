class TransportHoursController < ApplicationController
  before_action :set_transport_hour, only: [:show, :edit, :update, :destroy]

  # GET /transport_hours
  # GET /transport_hours.json
  def index
    @transport_hours = TransportHour.all
  end

  # GET /transport_hours/1
  # GET /transport_hours/1.json
  def show
  end

  # GET /transport_hours/new
  def new
    @transport_hour = TransportHour.new
  end

  # GET /transport_hours/1/edit
  def edit
  end

  # POST /transport_hours
  # POST /transport_hours.json
  def create
    @transport_hour = TransportHour.new(transport_hour_params)

    respond_to do |format|
      if @transport_hour.save
        format.html { redirect_to @transport_hour, notice: 'Transport hour was successfully created.' }
        format.json { render :show, status: :created, location: @transport_hour }
      else
        format.html { render :new }
        format.json { render json: @transport_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transport_hours/1
  # PATCH/PUT /transport_hours/1.json
  def update
    respond_to do |format|
      if @transport_hour.update(transport_hour_params)
        format.html { redirect_to @transport_hour, notice: 'Transport hour was successfully updated.' }
        format.json { render :show, status: :ok, location: @transport_hour }
      else
        format.html { render :edit }
        format.json { render json: @transport_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transport_hours/1
  # DELETE /transport_hours/1.json
  def destroy
    @transport_hour.destroy
    respond_to do |format|
      format.html { redirect_to transport_hours_url, notice: 'Transport hour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transport_hour
      @transport_hour = TransportHour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transport_hour_params
      params.require(:transport_hour).permit(:transport_id, :hour_id)
    end
end
