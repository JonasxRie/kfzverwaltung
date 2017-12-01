# Model-Klasse für die Dokumente
class Dokument < ApplicationRecord
  # Definition der Beziehung zu den Fahrzeugen
  belongs_to :fahrzeug

  # Konstruktor
  def initialize(params = {})
    super
    preprocess_file(params)
  end

  # Methode zum Ändern der Eigenschaften eines Dokuments
  def update(params)
    preprocess_file(params)
    super
  end

  # Aufbereitung der Datei bevor diese in der Datenbank gespeichert werden kann
  def preprocess_file(params)
    file = params.delete(:datei)    
    if file
      self.dateiname = sanitize_filename(file.original_filename)
      self.typ = file.content_type
      self.datei = file.read
    end
  end

  # Kürzen des Dateinamen mit vollständigem Pfad auf den Dateinamen
  def sanitize_filename(filename)
    return File.basename(filename)
  end
end
