class Dokument < ApplicationRecord
  belongs_to :fahrzeug

  def initialize(params = {})
    super
    preprocess_file(params)
  end

  def update(params)
    preprocess_file(params)
    super
  end

  def preprocess_file(params)
    file = params.delete(:datei)    
    if file
      self.dateiname = sanitize_filename(file.original_filename)
      self.typ = file.content_type
      self.datei = file.read
    end
  end

  def sanitize_filename(filename)
    return File.basename(filename)
  end
end
