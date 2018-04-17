class CreateArquivos < ActiveRecord::Migration
  def change
    create_table :arquivos do |t|
      t.string :diretorio
      t.string :nome
      t.date :data
	    t.string :usuario
	    t.integer :issue_id
    end
  end
end
