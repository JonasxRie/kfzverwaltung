class ChangeDateiToMediumblob < ActiveRecord::Migration[5.1]
  def change
    change_column(:dokuments, :datei, :binary, :limit => 10.megabyte)
  end
end
