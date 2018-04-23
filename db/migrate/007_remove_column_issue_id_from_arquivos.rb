class RemoveColumnIssueIdFromArquivos < ActiveRecord::Migration
  def change
    remove_column :arquivos, :issue_id, :integer
  end
end
