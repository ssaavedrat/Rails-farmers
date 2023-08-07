class FarmsController < ApplicationController
  before_action :set_farm, only: %i[ show edit update destroy ]

  # GET /farms or /farms.json
  def index
    @farms = Farm.all
  end

  # GET /farms/1 or /farms/1.json
  def show
  end

  # GET /farms/new
  def new
    @farm = Farm.new
  end

  # GET /farms/1/edit
  def edit
  end

  # POST /farms or /farms.json
  def create
    @farm = Farm.new(farm_params)

    respond_to do |format|
      if @farm.save
        format.html { redirect_to farm_url(@farm), notice: "Farm was successfully created." }
        format.json { render :show, status: :created, location: @farm }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @farm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /farms/1 or /farms/1.json
  def update
    respond_to do |format|
      if @farm.update(farm_params)
        format.html { redirect_to farm_url(@farm), notice: "Farm was successfully updated." }
        format.json { render :show, status: :ok, location: @farm }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @farm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /farms/1 or /farms/1.json
  def destroy
    @farm.destroy

    respond_to do |format|
      format.html { redirect_to farms_url, notice: "Farm was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_farm
      @farm = Farm.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def farm_params
      params.require(:farm).permit(:name)
    end
end
