class ListdirectoryController < ApplicationController

	def index
		@issue = Issue.find(params[:issue_id])
		#@arquivo = Arquivo.listaArquivos('.')
		#@arquivo = Arquivo.all(:conditions => { 'issue_id' =>  @issue.id})
    @arquivo = Arquivo.where(issue_id: @issue.id).order(nome: :asc)
	end

	def show
    redirect_back(fallback_location: root_path)
  end

  def buscararquivos
    @issue = Issue.find(params[:issue_id])
    @arquivosservidor = listaArquivos('.')
  end

	def listaArquivos(pathBusca)
		arquivos = []
		Dir.chdir(pathBusca)
		Dir.foreach(pathBusca) do |file|
			next if file == '.' or file == '..'
			arquivo = Arquivo.new
			arquivo.nome = file
			arquivo.diretorio = Dir.pwd
			arquivo.data = File.mtime(file)
			arquivo.usuario = File.stat(file).uid
			arquivos << arquivo
		end
		return arquivos
	end

	def anexar
		@issue = Issue.find(params[:issue_id])
		@arquivo = []
    @arquivonovo = Arquivo.new()
		#flash[:notice] = 'arquivo salvo.'
	end

  def preencheLista(pathBusca)
    arquivos = listaArquivos(pathBusca)
  end

  helper_method :listaArquivos

  def create
      @arquivo = Arquivo.new(arquivonovo_param)

      @arquivo.save
      #redirect_to action: index
  end
  def arquivonovo_param
    params.require(:arquivonovo).permit(:nome, :data, :issue_id)
  end
end
