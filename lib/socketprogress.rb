module Socketprogress

    def buscarFontesProgress( paramsocket)
      porta =  getNewPortSocket()
      servico = "RedmineFontesDifCliente"
      xmlParam =  montaXmlParametros(paramsocket, "buscarFontesProgress")
      xmlRequisicao = criaXmlRequisicao(servico,"",xmlParam )
      puts("esperando 1 segundo")
      sleep(1)
      puts("iniciando")
      @xmlTelaRequisicao = xmlRequisicao
      s = connect("prg01.datacoper.com.br", porta)
      s.print(xmlRequisicao.length)
      s.gets()
      s.print(xmlRequisicao)
      tamanho = s.gets # Read lines from socket

      if (!tamanho.equal?("0"))
        retorno = ""
        while line = s.gets # Read lines from socket
          retorno << line.strip       # and print them
        end
        retorno = retorno.strip
        s.close             # close socket when done
        @xmlTelaRetorno = retorno
        #@xmlTelaRetorno = "<res:processamento xmlns:res=\"http://www.datacoper.com/InterfaceadorProgress4J/RespostaServicoInterfaceadorProgress\"><res:resultado>SUCESSO</res:resultado><res:descricao>O programa foi executado com sucesso - fnt507i.p</res:descricao><res:dados><![CDATA[<dc:arquivos xmlns:dc=\"http://www.datacoper.com/cooperate/integracaosoftwareterceiro/server/integracaogeral\"><dc:registro><dc:nomeArquivo>agr107cl.p</dc:nomeArquivo><dc:tamanho>13118</dc:tamanho><dc:usuario>eduardo.silva</dc:usuario><dc:data>2017-01-03</dc:data><dc:hora></dc:hora><dc:extensao>p</dc:extensao><dc:nomeCompleto>/usr/pro/p/camp/dif/agr107cl.p</dc:nomeCompleto></dc:registro><dc:registro><dc:nomeArquivo>df127510.df</dc:nomeArquivo><dc:tamanho>12097</dc:tamanho><dc:usuario>fabio.oliveira</dc:usuario><dc:data>2016-05-04</dc:data><dc:hora></dc:hora><dc:extensao>df</dc:extensao><dc:nomeCompleto>/usr/pro/p/camp/dif/df127510.df</dc:nomeCompleto></dc:registro><dc:registro><dc:nomeArquivo>eso209.p.renatinho</dc:nomeArquivo><dc:tamanho>7882</dc:tamanho><dc:usuario>renato.schlogel</dc:usuario><dc:data>2017-10-09</dc:data><dc:hora></dc:hora><dc:extensao>renatinho</dc:extensao><dc:nomeCompleto>/usr/pro/p/camp/dif/eso209.p.renatinho</dc:nomeCompleto></dc:registro><dc:registro><dc:nomeArquivo>est115.p</dc:nomeArquivo><dc:tamanho>127589</dc:tamanho><dc:usuario>josimesio.pereira</dc:usuario><dc:data>2017-12-14</dc:data><dc:hora>17:08</dc:hora><dc:extensao>p</dc:extensao><dc:nomeCompleto>/usr/pro/p/camp/dif/est115.p</dc:nomeCompleto></dc:registro><dc:registro><dc:nomeArquivo>fcb101abc.i.edu</dc:nomeArquivo><dc:tamanho>19230</dc:tamanho><dc:usuario>eduardo.silva</dc:usuario><dc:data>2017-07-21</dc:data><dc:hora></dc:hora><dc:extensao>edu</dc:extensao><dc:nomeCompleto>/usr/pro/p/camp/dif/fcb101abc.i.edu</dc:nomeCompleto></dc:registro><dc:registro><dc:nomeArquivo>fcb101lc.i.edu</dc:nomeArquivo><dc:tamanho>27780</dc:tamanho><dc:usuario>eduardo.silva</dc:usuario><dc:data>2017-07-21</dc:data><dc:hora></dc:hora><dc:extensao>edu</dc:extensao><dc:nomeCompleto>/usr/pro/p/camp/dif/fcb101lc.i.edu</dc:nomeCompleto></dc:registro><dc:registro><dc:nomeArquivo>fcb101mc.i.edu</dc:nomeArquivo><dc:tamanho>28283</dc:tamanho><dc:usuario>eduardo.silva</dc:usuario><dc:data>2017-07-21</dc:data><dc:hora></dc:hora><dc:extensao>edu</dc:extensao><dc:nomeCompleto>/usr/pro/p/camp/dif/fcb101mc.i.edu</dc:nomeCompleto></dc:registro><dc:registro><dc:nomeArquivo>fcb101mc.w.edu</dc:nomeArquivo><dc:tamanho>3526</dc:tamanho><dc:usuario>eduardo.silva</dc:usuario><dc:data>2017-07-21</dc:data><dc:hora></dc:hora><dc:extensao>edu</dc:extensao><dc:nomeCompleto>/usr/pro/p/camp/dif/fcb101mc.w.edu</dc:nomeCompleto></dc:registro><dc:registro><dc:nomeArquivo>fcb101uc.i.edu</dc:nomeArquivo><dc:tamanho>28447</dc:tamanho><dc:usuario>eduardo.silva</dc:usuario><dc:data>2017-07-21</dc:data><dc:hora></dc:hora><dc:extensao>edu</dc:extensao><dc:nomeCompleto>/usr/pro/p/camp/dif/fcb101uc.i.edu</dc:nomeCompleto></dc:registro><dc:registro><dc:nomeArquivo>nfe502d1.p.daniel</dc:nomeArquivo><dc:tamanho>116915</dc:tamanho><dc:usuario>daniel.tokarski</dc:usuario><dc:data>2017-06-14</dc:data><dc:hora></dc:hora><dc:extensao>daniel</dc:extensao><dc:nomeCompleto>/usr/pro/p/camp/dif/nfe502d1.p.daniel</dc:nomeCompleto></dc:registro><dc:registro><dc:nomeArquivo>x7est407.pe</dc:nomeArquivo><dc:tamanho>14409</dc:tamanho><dc:usuario>eliel.dourado</dc:usuario><dc:data>2017-06-08</dc:data><dc:hora></dc:hora><dc:extensao>pe</dc:extensao><dc:nomeCompleto>/usr/pro/p/camp/dif/x7est407.pe</dc:nomeCompleto></dc:registro><dc:registro><dc:nomeArquivo>x7est626ec.p.fabio</dc:nomeArquivo><dc:tamanho>9329</dc:tamanho><dc:usuario>fabio.oliveira</dc:usuario><dc:data>2016-03-24</dc:data><dc:hora></dc:hora><dc:extensao>fabio</dc:extensao><dc:nomeCompleto>/usr/pro/p/camp/dif/x7est626ec.p.fabio</dc:nomeCompleto></dc:registro></dc:arquivos>]]></res:dados></res:processamento>"
        #@xmlTelaRetorno = "<res:processamento xmlns:res=\"http://www.datacoper.com/InterfaceadorProgress4J/RespostaServicoInterfaceadorProgress\"><res:resultado>ERRO</res:resultado><res:descricao>#Tentativa de executar o programa: [FontesDifCliente]. Erro: N�mero incompat�vel de par�metros passado para a rotina fnt507i.p. (3234)#</res:descricao><res:dados/></res:processamento>"
        processaRetorno(@xmlTelaRetorno)
      else
        geraErro()
      end
      puts("fim buscarFontesProgress")
    end

    def anexarFontesProgress(paramsocket)
      porta =  getNewPortSocket()
      servico = "RedmineAnexarFontesSolicitacao"
      xmlParam =  montaXmlParametros(paramsocket, "anexarFontesProgress")
      xmlDados = montaXmlDados(paramsocket, "anexarFontesProgress")
      xmlRequisicao = criaXmlRequisicao(servico,xmlDados,xmlParam )
      @debugxmlenvio = xmlRequisicao
      puts("esperando 1 segundo")
      sleep(1)
      puts("iniciando")

      s = connect("prg01.datacoper.com.br", porta)
      s.print(xmlRequisicao.length)
      s.gets()
      s.print(xmlRequisicao)
      tamanho = s.gets # Read lines from socket

      if (!tamanho.equal?("0"))
        retorno = ""
        while line = s.gets # Read lines from socket
          retorno << line.strip       # and print them
        end
        retorno = retorno.strip
        s.close             # close socket when done
        @debugxmlretorno = retorno
        processaRetorno(retorno)
      else
        geraErro()
      end
      puts("fim RedmineAnexarFontesSolicitacao")
    end

    def removeAnexoFonteProgress(paramsocket)
      porta =  getNewPortSocket()
      servico = "RedmineRemoveAnexoFonteProgress"
      xmlParam =  montaXmlParametros(paramsocket, "removeAnexoFonteProgress")
      xmlDados = montaXmlDados(paramsocket, "removeAnexoFonteProgress")
      xmlRequisicao = criaXmlRequisicao(servico,xmlDados,xmlParam )
      puts("esperando 1 segundo")
      sleep(1)
      puts("iniciando")
      @debugxmlenvio = xmlRequisicao
      s = connect("prg01.datacoper.com.br", porta)
      s.print(xmlRequisicao.length)
      s.gets()
      s.print(xmlRequisicao)
      tamanho = s.gets # Read lines from socket

      if (!tamanho.equal?("0"))
        retorno = ""
        while line = s.gets # Read lines from socket
          retorno << line.strip       # and print them
        end
        retorno = retorno.strip
        s.close             # close socket when done
        @debugxmlretorno = retorno
        processaRetorno(retorno)
      else
        geraErro()
      end
      puts("fim RedmineRemoveAnexoFonteProgress")
    end

    def geraErro()
      xmlerro = Nokogiri::XML::Builder.new{|xml|
        xml['res'].retornoservico("xmlns:res" => "http://www.datacoper.com/InterfaceadorProgress4J/RequisicaoServicoInterfaceadorProgress") do
          xml.descricao "Erro ao utilizar serviço de busca de arquivos Progess."
        end
      }.to_xml(:indent => 0, :save_with => Nokogiri::XML::Node::SaveOptions::AS_XML)
      processaRetornoErro(Nokogiri::XML(xmlerro))
    end

    def processaRetorno(xmlRetorno)
      xmlRetorno = xmlRetorno.strip
      indexInicio = xmlRetorno.index('<')
      if (indexInicio > -1)
        xml_doc = Nokogiri::XML(xmlRetorno[indexInicio..-1])
        if (xml_doc.xpath("//res:resultado").text() == "SUCESSO")
          processaRetornoSucesso(xml_doc.xpath("//res:dados[1]/node()"))
        else
          processaRetornoErro(xml_doc)
        end
      else
        puts("gerando erro")
        geraErro()
      end
    end

    def processaRetornoSucesso(xmlSucesso)
      @arquivosservidor = []
      xmlSucesso.each do |xml|
        xmlInterno = Nokogiri::XML(xml.text())
        xmlInterno.xpath("//dc:registro").each do |arq|
          arquivo = Arquivo.new
          arq.children.each do |sub_e|
            arquivo.nome = sub_e.inner_text if sub_e.name == 'nomeArquivo'
            arquivo.data = Date.parse(sub_e.inner_text) if sub_e.name == 'data'
            arquivo.hora = sub_e.inner_text if sub_e.name == 'hora'
            arquivo.usuario = sub_e.inner_text if sub_e.name == 'usuario'
            arquivo.extensao = sub_e.inner_text if sub_e.name == 'extensao'
            arquivo.tamanho = sub_e.inner_text if sub_e.name == 'tamanho'
          end
          @arquivosservidor << arquivo
        end
      end
    end

    def processaRetornoErro(xmlErro)
      puts(xmlErro)
      @xmlerro = xmlErro
      raise xmlErro
    end

    def getNewPortSocket
      retorno = 0
      s = connect("prg01.datacoper.com.br", 3566)
      s.print("libera_porta")
      line = s.gets # Read lines from socket
      retorno = line.chop         # and print them
      s.close             # close socket when done
      return retorno
    end

    def montaXmlParametros(paramsocket, tipo)
      xmlParam = ""
      case tipo
      when "buscarFontesProgress"
        xmlParam = Nokogiri::XML::Builder.new{|xml|
          xml['dc'].ExecutaServicoSock("xmlns:dc" => "http://www.datacoper.com/InterfaceadorProgress4J/RequisicaoServicoInterfaceadorProgress") do
            xml.registro do
              xml.cliente "\""+paramsocket[:cliente]+"\""
              xml.usuariobuscar "\""+paramsocket[:usuariobuscar]+"\""
              xml.marcarabuscar "\""+paramsocket[:marcarabuscar]+"\""
              xml.datainicialbuscar "\""+paramsocket[:datainicialbuscar]+"\""
              xml.datafinalbuscar "\""+paramsocket[:datafinalbuscar]+"\""
              xml.horainicialbuscar "\""+paramsocket[:horainicialbuscar]+"\""
              xml.horafinalbuscar "\""+paramsocket[:horafinalbuscar]+"\""
            end
          end
        }.to_xml(:indent => 0, :save_with => Nokogiri::XML::Node::SaveOptions::AS_XML)
      when "anexarFontesProgress"
        xmlParam = Nokogiri::XML::Builder.new{|xml|
          xml['dc'].ExecutaServicoSocket("xmlns:dc" => "http://www.datacoper.com/InterfaceadorProgress4J/RequisicaoServicoInterfaceadorProgress") do
            xml.registro do
              xml.codigofnt  paramsocket[:codigofnt]
              xml.cliente "\""+paramsocket[:cliente]+"\""
              xml.usuariobuscar "\"skt501\""
              xml.diretorio "\"\""
            end
          end
        }.to_xml(:indent => 0, :save_with => Nokogiri::XML::Node::SaveOptions::AS_XML)
      when "removeAnexoFonteProgress"
        xmlParam = Nokogiri::XML::Builder.new{|xml|
          xml['dc'].ExecutaServicoSocket("xmlns:dc" => "http://www.datacoper.com/InterfaceadorProgress4J/RequisicaoServicoInterfaceadorProgress") do
            xml.registro do
              xml.codigofnt paramsocket[:codigofnt]
              xml.cliente "\""+paramsocket[:cliente]+"\""
              xml.usuariobuscar "\"skt501\""
            end
          end
        }.to_xml(:indent => 0, :save_with => Nokogiri::XML::Node::SaveOptions::AS_XML)
      end

      return xmlParam.to_s
    end

    def montaXmlDados(paramsocket, tipo)
      xmlDados = ""
      case tipo
      when "anexarFontesProgress"
        xmlDados = Nokogiri::XML::Builder.new{|xml|
          xml['dc'].ExecutaServicoSocket("xmlns:dc" => "http://www.datacoper.com/InterfaceadorProgress4J/RequisicaoServicoInterfaceadorProgress") do
            paramsocket[:fontesanexados].each{|fonte|
              xml.registro do
                xml.fonte fonte.nome
              end
            }
          end
        }.to_xml(:indent => 0, :save_with => Nokogiri::XML::Node::SaveOptions::AS_XML)
      when "removeAnexoFonteProgress"
        xmlDados = Nokogiri::XML::Builder.new{|xml|
          xml['dc'].ExecutaServicoSocket("xmlns:dc" => "http://www.datacoper.com/InterfaceadorProgress4J/RequisicaoServicoInterfaceadorProgress") do
            paramsocket[:fontesremover].each{|fonte|
              xml.registro do
                xml.fonte fonte.nome
              end
            }
          end
        }.to_xml(:indent => 0, :save_with => Nokogiri::XML::Node::SaveOptions::AS_XML)
      end

      return xmlDados.to_s
    end

    def criaXmlRequisicao(servico,xmlDados, xmlParametros)
      xmlRequisicao = Nokogiri::XML::Builder.new {|xml|
        xml['req'].integracaoservico("xmlns:req" => "http://www.datacoper.com/InterfaceadorProgress4J/RequisicaoServicoInterfaceadorProgress") do
          xml.produto "Redmine - Plugin"
          xml.servico servico
          if (xmlDados != "")
            xml.dados do
              xml.cdata xmlDados
            end
          else
            xml.dados ""
          end
          if (xmlParametros != "")
            xml.parametros do
              xml.cdata xmlParametros
            end
          else
            xml.parametros ""
          end

        end}
      return xmlRequisicao.to_xml(:indent => 0, :save_with => Nokogiri::XML::Node::SaveOptions::AS_XML)
    end

    def connect(host, port, timeout = 5)

      # Convert the passed host into structures the non-blocking calls
      # can deal with
      addr = Socket.getaddrinfo(host, nil)
      sockaddr = Socket.pack_sockaddr_in(port, addr[0][3])

      Socket.new(Socket.const_get(addr[0][0]), Socket::SOCK_STREAM, 0).tap do |socket|
        socket.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)

        begin
          # Initiate the socket connection in the background. If it doesn't fail
          # immediatelyit will raise an IO::WaitWritable (Errno::EINPROGRESS)
          # indicating the connection is in progress.
          socket.connect_nonblock(sockaddr)

        rescue IO::WaitWritable
          # IO.select will block until the socket is writable or the timeout
          # is exceeded - whichever comes first.
          if IO.select(nil, [socket], nil, timeout)
            begin
              # Verify there is now a good connection
              socket.connect_nonblock(sockaddr)
            rescue Errno::EISCONN
              # Good news everybody, the socket is connected!
              return socket
            rescue
              # An unexpected exception was raised - the connection is no good.
              socket.close
              raise
            end
          else
            # IO.select returns nil when the socket is not ready before timeout
            # seconds have elapsed
            socket.close
            raise "Connection timeout"
          end
        end
      end
    end

end