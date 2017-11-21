json.extract! dokument, :id, :bezeichnung, :speicherdatum, :fahrzeug_id, :typ, :datei, :created_at, :updated_at
json.url dokument_url(dokument, format: :json)
