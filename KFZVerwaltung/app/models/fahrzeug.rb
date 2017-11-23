class Fahrzeug < ApplicationRecord
    has_many :dokuments, dependent: :destroy
end
