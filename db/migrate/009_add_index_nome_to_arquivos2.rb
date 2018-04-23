class AddIndexNomeToArquivos2 < ActiveRecord::Migration
  def change
    add_index :arquivos, [:nome, :issue_id], unique: true
  end
end
