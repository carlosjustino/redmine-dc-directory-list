class AddIndexNomeToArquivos < ActiveRecord::Migration
  def change
    add_index :arquivos, :nome
  end
end
