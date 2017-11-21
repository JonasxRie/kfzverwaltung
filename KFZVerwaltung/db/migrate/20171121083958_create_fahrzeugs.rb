class CreateFahrzeugs < ActiveRecord::Migration[5.1]
  def change
    create_table :fahrzeugs do |t|
      t.string :bezeichnung
      t.string :kennzeichen
      t.date :tuv
      t.integer :baujahr
      t.text :notizen
      t.boolean :archiviert

      t.timestamps
    end
  end
end
