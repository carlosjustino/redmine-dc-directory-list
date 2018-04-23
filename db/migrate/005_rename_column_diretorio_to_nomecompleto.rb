class RenameColumnDiretorioToNomecompleto < ActiveRecord::Migration
  def change
    rename_column :arquivos, :diretorio, :nomecompleto
  end
end
