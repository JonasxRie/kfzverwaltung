class AddDateinameToDokuments < ActiveRecord::Migration[5.1]
  def change
    add_column :dokuments, :dateiname, :string
  end
end
