class CreateDokuments < ActiveRecord::Migration[5.1]
  def change
    create_table :dokuments do |t|
      t.string :bezeichnung
      t.date :speicherdatum
      t.references :fahrzeug, foreign_key: true
      t.string :typ
      t.binary :datei

      t.timestamps
    end
  end
end
