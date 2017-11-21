class DokumentsController < ApplicationController
  before_action :set_dokument, only: [:show, :edit, :update, :destroy]

  # GET /dokuments
  # GET /dokuments.json
  def index
    @dokuments = Dokument.all
  end

  # GET /dokuments/1
  # GET /dokuments/1.json
  def show
  end

  # GET /dokuments/new
  def new
    @dokument = Dokument.new
  end

  # GET /dokuments/1/edit
  def edit
  end

  # POST /dokuments
  # POST /dokuments.json
  def create
    @dokument = Dokument.new(dokument_params)

    respond_to do |format|
      if @dokument.save
        format.html { redirect_to @dokument, notice: 'Dokument was successfully created.' }
        format.json { render :show, status: :created, location: @dokument }
      else
        format.html { render :new }
        format.json { render json: @dokument.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dokuments/1
  # PATCH/PUT /dokuments/1.json
  def update
    respond_to do |format|
      if @dokument.update(dokument_params)
        format.html { redirect_to @dokument, notice: 'Dokument was successfully updated.' }
        format.json { render :show, status: :ok, location: @dokument }
      else
        format.html { render :edit }
        format.json { render json: @dokument.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dokuments/1
  # DELETE /dokuments/1.json
  def destroy
    @dokument.destroy
    respond_to do |format|
      format.html { redirect_to dokuments_url, notice: 'Dokument was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dokument
      @dokument = Dokument.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dokument_params
      params.require(:dokument).permit(:bezeichnung, :speicherdatum, :fahrzeug_id, :typ, :datei)
    end
end
