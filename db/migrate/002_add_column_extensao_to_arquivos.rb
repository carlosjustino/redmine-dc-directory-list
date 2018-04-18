class AddColumnExtensaoToArquivos < ActiveRecord::Migration
  def change
    add_column :arquivos, :extensao, :string
  end
end
