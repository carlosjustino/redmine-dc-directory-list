class ListdirectoryController < ApplicationController
  include Socketprogress

  def telafiltroanexos
    @issue = Issue.find(params[:issue_id])
    @customFieldCliente = IssueCustomField.find_by_name('Cliente')
    @clienteprogress = @issue.custom_field_value(@customFieldCliente)
    @clienteprogress = @customFieldCliente.enumerations.find(@clienteprogress)
  rescue => e
    @error = e
    redirecionapaginaerro("","","")
  end

	def index
		@issue = Issue.find(params[:issue_id])
    @arquivobanco = Arquivo.where(issue_id: @issue.id).order(nome: :asc)
    @customFieldCliente = IssueCustomField.find_by_name('Cliente')
    @clienteprogress = @issue.custom_field_value(@customFieldCliente)
    @clienteprogress = @customFieldCliente.enumerations.find(@clienteprogress)
  rescue => e
    @error = e
    redirecionapaginaerro("","","")
	end

	def show
    redirect_to :action => 'index',"issue_id" => params[:issue_id]
  end

  def buscararquivos
    @issue = Issue.find(params[:issue_id])
    @arquivosservidor = []
		@customFieldCliente = IssueCustomField.find_by_name('Cliente')
		@clienteprogress = @issue.custom_field_value(@customFieldCliente)
    @clienteprogress = @customFieldCliente.enumerations.find(@clienteprogress)
    paramsocket = params.merge(cliente: @clienteprogress.to_s)
    invocaServicoProgress(paramsocket)
  rescue => e
    @error = e
    redirecionapaginaerro("","","")
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

  def redirecionapaginaerro(classeErro, mensagemErro, backtraceErro)

    @classeTelaError = classeErro
    @mensagemTelaErro = mensagemErro
    @backtraceTelaErro = backtraceErro

    if @classeTelaError == "" && @error
      @classeTelaError = @error.class.name
      @mensagemTelaErro = @error.message
      @backtraceTelaErro = @error.backtrace
    end
    render :errorpage
  end

  def errorpage
    @issue = Issue.find(params[:issue_id])
    @customFieldCliente = IssueCustomField.find_by_name('Cliente')
    @clienteprogress = @issue.custom_field_value(@customFieldCliente)
    @clienteprogress = @customFieldCliente.enumerations.find(@clienteprogress)
  end

	def anexarfontes
    @issue = Issue.find(params[:issue_id])
    @customFieldCliente = IssueCustomField.find_by_name('Cliente')
    @clienteprogress = @issue.custom_field_value(@customFieldCliente)
    @clienteprogress = @customFieldCliente.enumerations.find(@clienteprogress)
    arquivosAnexados = ""
    arquivosEnviar = params[:arquivosEnviar]
    arquivosEnviar.split(/\|/).each{ |cur|
      current = cur
      if current[0] == ',' then
         current = cur[1, cur.length]
      end
      currentValue = current.split(/,/)
      data = ""
      data = currentValue[2].split(/\//) if currentValue[2] != ""
      if data == ""
        data = "01/01/1970".split(/\//)
      end
      arquivosAnexados = arquivosAnexados + currentValue[0] + "\n"
      arquivo = Arquivo.new
      arquivo.nome = currentValue[0]
      arquivo.extensao = currentValue[1]
      arquivo.data = Date.new(Integer(data[2]),Integer(data[1]),Integer(data[0]))
      arquivo.hora = currentValue[3]
      arquivo.tamanho = currentValue[4]
      arquivo.usuario = currentValue[5]
      arquivo.issue_id = currentValue[6]
      arquivo.save
    }
    user = User.current
    journal = @issue.init_journal(user, "Anexo de fontes: \n" + arquivosAnexados)
	  journal.private_notes = true
    journal.save
    flash[:notice] = 'Lista salva.'
    #redirect_back_or_default(:view_file_progress, "issue_id"=> params[:issue_id], "authenticity_token" => params[:authenticity_token])
    redirect_to :action => 'index', :issue_id => params[:issue_id]
  rescue ActiveRecord::RecordNotUnique => e
    @error = e
    redirecionapaginaerro("Erro ao anexar fonte", "Fonte ja anexado a esta tarefa.", @error.message)
  rescue => e
    @error = e
    redirecionapaginaerro("","","")
	end

  def removerfontes
    @issue = Issue.find(params[:issue_id])
    @customFieldCliente = IssueCustomField.find_by_name('Cliente')
    @clienteprogress = @issue.custom_field_value(@customFieldCliente)
    @clienteprogress = @customFieldCliente.enumerations.find(@clienteprogress)
    arquivosAnexados = []
    arquivosRemovidos = ""
    arquivosRemover = params[:arquivosRemover]
    arquivosRemover.split(/\|/).each{ |cur|
      current = cur
      if current[0] == ',' then
        current = cur[1, cur.length]
      end
      currentValue = current.split(/,/)
      arquivosRemovidos = arquivosRemovidos + currentValue[0] + "\n"
      arquivo = Arquivo.where(nome: currentValue[0], issue_id: currentValue[1]).take!
      arquivosAnexados << arquivo
      arquivo.destroy
    }

    user = User.current
    journal = @issue.init_journal(user, "Fontes removidos: \n" + arquivosRemovidos)
    journal.private_notes = true
    journal.save
    flash[:notice] = 'Selecionados Removidos.'
    redirect_to :action => 'index', :issue_id => params[:issue_id]
  rescue => e
    @error = e
    redirecionapaginaerro("","","")
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
