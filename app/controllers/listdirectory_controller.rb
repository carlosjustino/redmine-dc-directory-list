class ListdirectoryController < ApplicationController
  include Socketprogress

  def telafiltroanexos
    @issue = Issue.find(params[:issue_id])
    customField = IssueCustomField.find_by_name('Cliente')
    @clienteprogress = @issue.custom_field_value(customField)
    @clienteprogress = customField.enumerations.find(@clienteprogress)
    customField = IssueCustomField.find_by_name('Solicitação FNT')
    @solicitacaoFNT = @issue.custom_field_value(customField)
    verificaNecessidades(params[:issue_id], "Filtro para buscar fontes.")
  rescue => e
    @error = e
    redirecionapaginaerro("","","")
  end

  def index
    @issue = Issue.find(params[:issue_id])
    @arquivobanco = Arquivo.where(issue_id: @issue.id).order(nome: :asc)
    customField = IssueCustomField.find_by_name('Cliente')
    @clienteprogress = @issue.custom_field_value(customField)
    @clienteprogress = customField.enumerations.find(@clienteprogress)
    customField = IssueCustomField.find_by_name('Solicitação FNT')
    @solicitacaoFNT = @issue.custom_field_value(customField)
    verificaNecessidades(params[:issue_id], "Apresentação de fontes anexados.")
  rescue => e
    @error = e
    redirecionapaginaerro("","","")
  end

  def show
    redirect_to :action => 'index',"issue_id" => params[:issue_id]
  end

  def buscararquivos
    @arquivosservidor = []
    @issue = Issue.find(params[:issue_id])
    customField = IssueCustomField.find_by_name('Cliente')
    @clienteprogress = @issue.custom_field_value(customField)
    @clienteprogress = customField.enumerations.find(@clienteprogress)
    customField = IssueCustomField.find_by_name('Solicitação FNT')
    @solicitacaoFNT = @issue.custom_field_value(customField)
    verificaNecessidades(params[:issue_id], "Seleção para Anexo dos fontes.")
    paramsocket = params.merge(cliente: @clienteprogress.to_s)
    buscarFontesProgress(paramsocket)
  rescue => e
    @error = e
    redirecionapaginaerro("","","")
  end

  def acionarServicoAnexoFonteProgress(arquivosanexados)
    if (!@issue)
      @issue = Issue.find(params[:issue_id])
    end
    customField = IssueCustomField.find_by_name('Cliente')
    @clienteprogress = @issue.custom_field_value(customField)
    @clienteprogress = customField.enumerations.find(@clienteprogress)
    customField = IssueCustomField.find_by_name('Solicitação FNT')
    @solicitacaoFNT = @issue.custom_field_value(customField)
    verificaNecessidades(@issue.id, "acionarServicoAnexoFonteProgress.")
    paramsocket = params.merge(cliente: @clienteprogress.to_s)
    paramsocket = paramsocket.merge(codigofnt: @solicitacaoFNT.to_s)
    paramsocket = paramsocket.merge(fontesanexados: arquivosanexados)
    anexarFontesProgress(paramsocket)
  #rescue => e deixa para quem chamou
  #  @error = e
  #  redirecionapaginaerro("","","")
  end

  def acionarServicoRemoveAnexoFonteProgress(fontesremover)
    if (!@issue)
      @issue = Issue.find(params[:issue_id])
    end
    customField = IssueCustomField.find_by_name('Cliente')
    @clienteprogress = @issue.custom_field_value(customField)
    @clienteprogress = customField.enumerations.find(@clienteprogress)
    customField = IssueCustomField.find_by_name('Solicitação FNT')
    @solicitacaoFNT = @issue.custom_field_value(customField)
    verificaNecessidades(@issue.id, "acionarServicoRemoveAnexoFonteProgress.")
    paramsocket = params.merge(cliente: @clienteprogress.to_s)
    paramsocket = paramsocket.merge(codigofnt: @solicitacaoFNT.to_s)
    paramsocket = paramsocket.merge(fontesremover: fontesremover)
    removeAnexoFonteProgress(paramsocket)
    #rescue => e deixa para quem chamou
    #  @error = e
    #  redirecionapaginaerro("","","")
  end

  def anexarfontes
    @issue = Issue.find(params[:issue_id])
    customField = IssueCustomField.find_by_name('Cliente')
    @clienteprogress = @issue.custom_field_value(customField)
    @clienteprogress = customField.enumerations.find(@clienteprogress)
    customField = IssueCustomField.find_by_name('Solicitação FNT')
    @solicitacaoFNT = @issue.custom_field_value(customField)
    verificaNecessidades(params[:issue_id], "Anexar fontes.")
    ActiveRecord::Base.transaction do

      arquivosAnexados = ""
      arquivosAnexadosProgress = []
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
        arquivosAnexadosProgress << arquivo
      }
      acionarServicoAnexoFonteProgress(arquivosAnexadosProgress)
      user = User.current
      journal = @issue.init_journal(user, "Anexo de fontes: \n" + arquivosAnexados)
      journal.private_notes = true
      journal.save
    end
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
    customField = IssueCustomField.find_by_name('Cliente')
    @clienteprogress = @issue.custom_field_value(customField)
    @clienteprogress = customField.enumerations.find(@clienteprogress)
    customField = IssueCustomField.find_by_name('Solicitação FNT')
    @solicitacaoFNT = @issue.custom_field_value(customField)
    verificaNecessidades(params[:issue_id], "Remover fontes.")

    ActiveRecord::Base.transaction do
      arquivosRemoverProgress = []
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
        arquivosRemoverProgress << arquivo
      }
      acionarServicoRemoveAnexoFonteProgress(arquivosRemoverProgress)
      arquivosRemoverProgress.each{ |arq|
        arq.destroy
      }
      user = User.current
      journal = @issue.init_journal(user, "Fontes removidos: \n" + arquivosRemovidos)
      journal.private_notes = true
      journal.save
    end
    flash[:notice] = 'Selecionados Removidos.'
    redirect_to :action => 'index', :issue_id => params[:issue_id]
  rescue => e
    @error = e
    redirecionapaginaerro("","","")
  end
  
  def verificaNecessidades(issue_id, backtraceErro)
    @issue = Issue.find(issue_id)
    erros = ""
    if @issue
      customField = IssueCustomField.find_by_name('Cliente')
      valorcampo = @issue.custom_field_value(customField)
      valorcampo = customField.enumerations.find(valorcampo)

      if valorcampo == ""
        erros << "Não foi encontrado o Cliente relacionado a esta tarefa do REDMINE. \n"
      end

      customField = IssueCustomField.find_by_name('Solicitação FNT')
      valorcampo = @issue.custom_field_value(customField)
      if valorcampo == "" || valorcampo <= "0"
        erros << "Não foi vinculada uma solicitação do FNT a esta tarefa do REDMINE. \n"
      end
    else
      erros << "Não foi encontrado a tarefa do Redmine."
    end
    if (erros != "")
      @error = ""
      redirecionapaginaerro("Erro de verificacao",erros,"Verificação: " + backtraceErro)
    end
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
    if (!@issue)
      @issue = Issue.find(params[:issue_id])
    end
    customField = IssueCustomField.find_by_name('Cliente')
    @clienteprogress = @issue.custom_field_value(customField)
    @clienteprogress = customField.enumerations.find(@clienteprogress)
    customField = IssueCustomField.find_by_name('Solicitação FNT')
    @solicitacaoFNT = @issue.custom_field_value(customField)
  end

end
