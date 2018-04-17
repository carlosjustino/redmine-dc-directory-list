class AddColumnTamanhoToArquivo < ActiveRecord::Migration
  def change
    add_column :arquivos, :tamanho, :string
  end
end
