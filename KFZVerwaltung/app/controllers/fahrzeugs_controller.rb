class FahrzeugsController < ApplicationController
  before_action :set_fahrzeug, only: [:show, :edit, :update, :destroy]

  # GET /fahrzeugs
  # GET /fahrzeugs.json
  def index
    # Filter und Sortierung anwenden
    @fahrzeugs = Fahrzeug.all

    if params[:filter] && !params[:filter].empty?
      if params[:filter] == '0'
        # FILTER: alle Fahrzeuge
        if params[:sort] && !params[:sort].empty?
          if params[:sort] == 'asc'
            # SORT: aufsteigend sortieren
            @fahrzeugs = Fahrzeug.order(params[:col])
          else
            # SORT: absteigend sortieren
            @fahrzeugs = Fahrzeug.all #TODO
          end
        else 
          @fahrzeugs = Fahrzeug.all
        end
      else
        # FILTER: nur archivierte Fahrzeuge
        if params[:sort] && !params[:sort].empty?
          if params[:sort] == 'asc'
            # SORT: aufsteigend sortieren
            @fahrzeugs = Fahrzeug.where(:archiviert => 1).order(params[:col])
          else
            # SORT: absteigend sortieren
            @fahrzeugs = Fahrzeug.where(:archiviert => 1) #TODO
          end
        else
          @fahrzeugs = Fahrzeug.where(:archiviert => 1)
        end
      end

    else
      # KEIN FILTER: nur aktive Fahrzeuge
      if params[:sort] && !params[:sort].empty?
        if params[:sort] == 'asc'
          # SORT: aufsteigend sortieren
          @fahrzeugs = Fahrzeug.where(:archiviert => 0).order(params[:col])
        else
          # SORT: absteigend sortieren
          @fahrzeugs = Fahrzeug.where(:archiviert => 0) #TODO
        end
      else
        @fahrzeug = Fahrzeug.where(:archiviert => 0)
      end
    end
  end

  # GET /fahrzeugs/1
  # GET /fahrzeugs/1.json
  def show
  end

  # GET /fahrzeugs/new
  def new
    @fahrzeug = Fahrzeug.new
  end

  # GET /fahrzeugs/1/edit
  def edit
  end

  # POST /fahrzeugs
  # POST /fahrzeugs.json
  def create
    @fahrzeug = Fahrzeug.new(fahrzeug_params)

    respond_to do |format|
      if @fahrzeug.save
        format.html { redirect_to @fahrzeug, notice: 'Fahrzeug was successfully created.' }
        format.json { render :show, status: :created, location: @fahrzeug }
      else
        format.html { render :new }
        format.json { render json: @fahrzeug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fahrzeugs/1
  # PATCH/PUT /fahrzeugs/1.json
  def update
    respond_to do |format|
      if @fahrzeug.update(fahrzeug_params)
        format.html { redirect_to @fahrzeug, notice: 'Fahrzeug was successfully updated.' }
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

  # DELETE /fahrzeugs/1
  # DELETE /fahrzeugs/1.json
  def destroy
    @fahrzeug.destroy
    respond_to do |format|
      format.html { redirect_to fahrzeugs_url, notice: 'Fahrzeug was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fahrzeug
      @fahrzeug = Fahrzeug.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fahrzeug_params
      params.require(:fahrzeug).permit(:bezeichnung, :kennzeichen, :tuv, :baujahr, :notizen, :archiviert)
    end
end
