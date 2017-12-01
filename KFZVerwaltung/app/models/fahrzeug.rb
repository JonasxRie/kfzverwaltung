# Model-Klasse für die Fahrzeuge
class Fahrzeug < ApplicationRecord
    # Definition der Beziehung zu den Dokumenten
    # Assozierte Dokumente werden bei Löschung des Fahrzeuges ebenfalls gelöscht
    has_many :dokuments, dependent: :destroy
end