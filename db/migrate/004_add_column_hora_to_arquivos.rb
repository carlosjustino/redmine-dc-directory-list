class AddColumnHoraToArquivos < ActiveRecord::Migration
  def change
    add_column :arquivos, :hora, :string
  end
end
