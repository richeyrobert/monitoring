class DevtypesController < ApplicationController
  before_action :set_devtype, only: [:show, :edit, :update, :destroy]

  # GET /devtypes
  # GET /devtypes.json
  def index
    @devtypes = Devtype.all
  end

  # GET /devtypes/1
  # GET /devtypes/1.json
  def show
  end

  # GET /devtypes/new
  def new
    @devtype = Devtype.new
  end

  # GET /devtypes/1/edit
  def edit
  end

  # POST /devtypes
  # POST /devtypes.json
  def create
    @devtype = Devtype.new(devtype_params)

    respond_to do |format|
      if @devtype.save
        format.html { redirect_to @devtype, notice: 'Devtype was successfully created.' }
        format.json { render :show, status: :created, location: @devtype }
      else
        format.html { render :new }
        format.json { render json: @devtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devtypes/1
  # PATCH/PUT /devtypes/1.json
  def update
    respond_to do |format|
      if @devtype.update(devtype_params)
        format.html { redirect_to @devtype, notice: 'Devtype was successfully updated.' }
        format.json { render :show, status: :ok, location: @devtype }
      else
        format.html { render :edit }
        format.json { render json: @devtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devtypes/1
  # DELETE /devtypes/1.json
  def destroy
    @devtype.destroy
    respond_to do |format|
      format.html { redirect_to devtypes_url, notice: 'Devtype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_devtype
      @devtype = Devtype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def devtype_params
      params.require(:devtype).permit(:name, :manufacturer, :model, :notes, :active, :archived_at)
    end
end
