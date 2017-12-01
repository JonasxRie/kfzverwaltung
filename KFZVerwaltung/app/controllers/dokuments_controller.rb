class DokumentsController < ApplicationController
  before_action :set_dokument, only: [:show, :edit, :update, :destroy]

  # Bereitstellung der Daten für die Listenansicht
  # Wird bei dem Aufruf der folgenden URL ausgeführt:
  # GET /dokuments
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
          @dokuments = Dokument.joins("INNER JOIN fahrzeugs ON dokuments.fahrzeug_id = fahrzeugs.id WHERE archiviert = 0").order('fahrzeugs.bezeichnung' + params[:sort])
        else
          @dokuments = Dokument.joins("INNER JOIN fahrzeugs ON dokuments.fahrzeug_id = fahrzeugs.id WHERE archiviert = 0").order(params[:col] + params[:sort])
        end
      else
        # OHNE Sortierung
        @dokuments = Dokument.joins("INNER JOIN fahrzeugs ON dokuments.fahrzeug_id = fahrzeugs.id WHERE archiviert = 0")
      end

    end
  end

  # Bereitstellung der Daten für die Detailansicht
  # Wird bei dem Aufruf der folgenden URL ausgeführt:
  # GET /dokuments/1
  def show
    @dokument = Dokument.find(params[:id])
  end
  
  # Download der Datei auf das Endgerät des Anwenders
  def download_file
    @dokument = Dokument.find(params[:id])
    send_data(@dokument.datei, type: @dokument.typ, filename: @dokument.dateiname)
  end

  # Wird bei dem Aufruf der folgenden URL ausgeführt und ermöglicht die Neuanlage:
  # GET /dokuments/new
  def new
    @dokument = Dokument.new
  end

  # Wird bei dem Aufruf der folgenden URL ausgeführt:
  # GET /dokuments/1/edit
  def edit
  end


  # Erstellt eine neue Instanz der des Models und speichert es in der Datenbank
  def create
    @dokument = Dokument.new(dokument_params)

    respond_to do |format|
      if @dokument.save
        format.html { redirect_to @dokument, notice: 'Dokument wurde erfolgreich angelegt.' }
        format.json { render :show, status: :created, location: @dokument }
      else
        format.html { render :new }
        format.json { render json: @dokument.errors, status: :unprocessable_entity }
      end
    end
  end

  # Ändert die Attribute eines Dokuments in der Datenbank
  def update
    respond_to do |format|
      if @dokument.update(dokument_params)
        format.html { redirect_to @dokument, notice: 'Dokument wurde erfolgreich bearbeitet.' }
        format.json { render :show, status: :ok, location: @dokument }
      else
        format.html { render :edit }
        format.json { render json: @dokument.errors, status: :unprocessable_entity }
      end
    end
  end

  # Löscht ein Dokument
  def destroy
    @dokument.destroy
    respond_to do |format|
      format.html { redirect_to dokuments_url, notice: 'Dokument wurde erfolgreich gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
    # Setzt die Instanzvariable mit dem aktuellen Dokument
    def set_dokument
      @dokument = Dokument.find(params[:id])
    end

    # Definiert welche Parameter übergeben werden dürfen
    def dokument_params
      params.require(:dokument).permit(:bezeichnung, :speicherdatum, :fahrzeug_id, :typ, :datei)
    end
end
