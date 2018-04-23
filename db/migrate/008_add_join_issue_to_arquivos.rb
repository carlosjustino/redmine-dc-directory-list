class AddJoinIssueToArquivos < ActiveRecord::Migration
  def change
    add_reference :arquivos, :issue, foreign_key: true
  end
end
