class FahrzeugsController < ApplicationController
  before_action :set_fahrzeug, only: [:show, :edit, :update, :destroy]

  # Bereitstellung der Daten für die Listenansicht
  # Wird bei dem Aufruf der folgenden URL ausgeführt:
  # GET /dokuments
  # GET /fahrzeugs
  def index
    # Filter und Sortierung anwenden

    if !params[:filter] || params[:filter].empty?

      # AKTIVE Fahrzeuge
      if params[:sort] && !params[:sort].empty?
        # Sortieren: params:[:sort] enthält entweder ' ASC' oder ' DESC'
        @fahrzeugs = Fahrzeug.where(:archiviert => 0).order(params[:col] + params[:sort])
      else
        # OHNE Sortierung
        @fahrzeugs = Fahrzeug.where(:archiviert => 0)
      end

    elsif params[:filter] == '1'

      # ARCHIVIERTE Fahrzeuge
      if params[:sort] && !params[:sort].empty?
        # Sortieren: params:[:sort] enthält entweder ' ASC' oder ' DESC'
        @fahrzeugs = Fahrzeug.where(:archiviert => 1).order(params[:col] + params[:sort])
      else
        # OHNE Sortierung
        @fahrzeugs = Fahrzeug.where(:archiviert => 1)
      end

    elsif params[:filter] == '0'

      # ALLE Fahrzeuge
      if params[:sort] && !params[:sort].empty?
        # Sortieren: params:[:sort] enthält entweder ' ASC' oder ' DESC'
        @fahrzeugs = Fahrzeug.order(params[:col] + params[:sort])
      else
        # OHNE Sortierung
        @fahrzeugs = Fahrzeug.all
      end

    end
  end

  # Bereitstellung der Daten für die Detailansicht
  # Wird bei dem Aufruf der folgenden URL ausgeführt:
  # GET /fahrzeugs/1
  def show
    @dokuments = Dokument.joins("INNER JOIN fahrzeugs ON dokuments.fahrzeug_id = fahrzeugs.id WHERE dokuments.fahrzeug_id = '#{@fahrzeug.id}'")
  end

  # Wird bei dem Aufruf der folgenden URL ausgeführt und ermöglicht die Neuanlage:
  # GET /fahrzeugs/new
  def new
    @fahrzeug = Fahrzeug.new
  end

  # Wird bei dem Aufruf der folgenden URL ausgeführt:
  # GET /fahrzeugs/1/edit
  def edit
  end

  # Erstellt eine neue Instanz der des Models und speichert es in der Datenbank
  def create
    @fahrzeug = Fahrzeug.new(fahrzeug_params)
    respond_to do |format|
      if @fahrzeug.save
        format.html { redirect_to @fahrzeug, notice: 'Fahrzeug wurde erfolgreich angelegt.' }
        format.json { render :show, status: :created, location: @fahrzeug }
      else
        format.html { render :new }
        format.json { render json: @fahrzeug.errors, status: :unprocessable_entity }
      end
    end
  end

  # Ändert die Attribute eines Fahrzeugs in der Datenbank
  def update
    respond_to do |format|
      if @fahrzeug.update(fahrzeug_params)
        format.html { redirect_to @fahrzeug, notice: 'Fahrzeug wurde erfolgreich bearbeitet.' }
        format.json { render :show, status: :ok, location: @fahrzeug }
      else
        format.html { render :edit }
        format.json { render json: @fahrzeug.errors, status: :unprocessable_entity }
      end
    end
  end

  # Fahrzeug archivieren
  def archive
    puts params[:id]
    kfz = Fahrzeug.find(params[:id])
    kfz.update_attribute(:archiviert, true)
    redirect_to fahrzeugs_path
  end

  # Löscht ein Fahrzeug
  def destroy
    @fahrzeug.destroy
    respond_to do |format|
      format.html { redirect_to fahrzeugs_url, notice: 'Fahrzeug wurde erfolgreich gelöscht.' }
      format.json { head :no_content }
    end
  end

  private
    # Setzt die Instanzvariable mit dem aktuellen Fahrzeug
    def set_fahrzeug
      @fahrzeug = Fahrzeug.find(params[:id])
    end

    # Definiert welche Parameter übergeben werden dürfen
    def fahrzeug_params
      params.require(:fahrzeug).permit(:bezeichnung, :kennzeichen, :tuv, :baujahr, :notizen, :archiviert)
    end
end
