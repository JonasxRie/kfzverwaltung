json.extract! fahrzeug, :id, :bezeichnung, :kennzeichen, :tuv, :baujahr, :notizen, :archiviert, :created_at, :updated_at
json.url fahrzeug_url(fahrzeug, format: :json)
