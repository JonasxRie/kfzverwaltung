class DokumentsController < ApplicationController
  before_action :set_dokument, only: [:show, :edit, :update, :destroy]

  # GET /dokuments
  # GET /dokuments.json
  def index
    if params[:f] && !params[:f].empty?
      # Dokumente nach einem Fahrzeug filtern

      if params[:sort] && !params[:sort].empty? && params[:col] != 'fahrzeug'
        # Sortieren: params:[:sort] enthält entweder ' ASC' oder ' DESC'
        # Nach Fahrzeug muss hier nicht gefiltert werden, da sowieso nur ein Wert in der Spalte ist
        @dokuments = Dokument.where(:fahrzeug_id => params[:f]).order(params[:col] + params[:sort])
      else
        # OHNE Sortierung
        @dokuments = Dokument.where(:fahrzeug_id => params[:f])
      end

    else
      # Alle Dokumente anzeigen

      if params[:sort] && !params[:sort].empty?
        # Sortieren: params:[:sort] enthält entweder ' ASC' oder ' DESC'
        if params[:col] == 'fahrzeug'
          @dokuments = Dokument.joins(:fahrzeug).order('fahrzeugs.bezeichnung' + params[:sort])
        else
          @dokuments = Dokument.order(params[:col] + params[:sort])
        end
      else
        # OHNE Sortierung
        @dokuments = Dokument.all
      end

    end
  end

  # GET /dokuments/1
  # GET /dokuments/1.json
  def show
    @dokument = Dokument.find(params[:id])
    # send_data @dokument.datei, type: 'pdf', filename: @dokument.bezeichnung + '.pdf'
    # send_file @dokument.datei, filename: @dokument.bezeichnung + '.pdf 
  end
  
  def download_file
    @dokument = Dokument.find(params[:id])
    puts @dokument.bezeichnung
    send_data(@dokument.datei, type: @dokument.typ, filename: @dokument.dateiname)
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
