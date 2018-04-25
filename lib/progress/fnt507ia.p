/*---------------------------------------------------------------------------*\
 *                   D A T A C O P E R     S O F T W A R E                   *
\*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*\
  Sistema....: Interfaceamento Cooperate Progress 
  Subsistema.: Interfaceador
  Programa...: fnt507ia.p
  Funcao.....: Anexa fontes na solicitacao vindo do redmine.  
  Responsavel: Carlos Eduardo Justino
  Data inicio: 24/04/2018
\*---------------------------------------------------------------------------*/

{bib00166.i}.
{utl511ls.i new}.
{skt507.i
   &variavelProduto = pc_produto
   &variavelDados   = pm_dados
   &variavelRetorno = pm_retorno
   }.

{fnt227.i
  &aprestaMsgTela = No}.

Def input param  pi_codigo        as int.
Def input param  pc_cliente       as char.
Def input param  pc_usuario       as char.
def input param  pc_diretorio     as char.

def var vc_erroInicio             as char.
def var vc_error                  as char.

Function getErroVerificacaoIncial returns char () forward.

def new shared temp-table anexos
    field NomeArquivo          as char
    field anexado              as log
    field erro                 as char
.

for each anexos.
    delete anexos.
end.
    
{skt506.i
   &new    = shared
   &file   = anexos
   &raiz   = "anexo"
   &dc     = "dc"
   }.

assign vl_ok = no.
bloco:
repeat
   on error  undo bloco, leave bloco
   on endkey undo bloco, leave bloco
   on stop   undo bloco, leave bloco
   on quit   undo bloco, leave bloco
   .   
   
   vc_erroInicio = getErroVerificacaoIncial().
   
   if vc_erroInicio ne '' then 
      do.
         find first t_Retorno
                    no-error.
         if not avail t_Retorno then do.
            create t_Retorno.
            assign t_Retorno.resultado = 'ERRO'.
         end.
         t_Retorno.descricao = t_Retorno.descricao + '#' +
                             vc_erroInicio.
         leave.
      end.
  
   /*carrega vm_xmldados.***/

    if get-size(pm_dados) > 0 then do.
       /*Cria tmp apartir do vm_XMLDADOS*/ 
       run fnt507ca.p ( input pm_dados).  
    end.

   find first anexos no-error.    
   
   if not avail ANEXOS then do.    
      find first t_Retorno
                 no-error.
      if not avail t_Retorno then do.
         create t_Retorno.
         assign t_Retorno.resultado = 'ERRO'.
      end.
      t_Retorno.descricao = t_Retorno.descricao + '#' +
                          'Nao foi enviado dados para anexar!'
                          + String(get-size(pm_dados))
                          + '!'.
      leave.                    
   end.
   else do.
         run VerificarFonteExiste in this-procedure.
        
         Run VerificarFonteAnexoOutraSOlicitacao in this-procedure.
      
         run VerificarFonteBloqueadoParaEnvio in this-procedure.
      
         Run AnexarFonteSolicitacao in this-procedure.
   end.
   vc_error = ''.
   if can-find(first anexos where anexos.anexado eq no) then do.
      for each anexos where anexos.erro ne ''.
          assign vc_error = vc_error 
                          + anexos.nomeArquivo
                          + ': '
                          + anexos.erro
                          + chr(10).
      end.
      for each anexos where anexos.anexado eq yes.
         run DeletarRegistroDeAnexo in this-procedure
          (input 1,
           input pi_codigo,
           input anexos.NomeArquivo).
         if return-value ne 'DeletarRegistroDeAnexo_ok' then 
            do.
               assign vc_error = vc_error 
                               + anexos.nomeArquivo
                               + ': '
                               + getDescricaoReturnComErro(return-value)
                               + chr(10).
            end.
          anexos.anexado = no.
      end.
   
      find first t_Retorno no-error.
      if not avail t_Retorno then  create t_Retorno.
      assign t_Retorno.resultado = 'ERRO'
             t_Retorno.descricao = t_Retorno.descricao + '#' + vc_error
             vl_ok = no.
      leave.
   end.
   
   run criarocorrencia in this-procedure.
   assign vl_ok = yes.
   leave.
   
 end.
 set-size(pm_dados) = 0.
      
{skt506a.i
   &file   = anexos
   }.

Procedure VerificarFonteAnexoOutraSOlicitacao.
for each anexos
   where anexos.erro eq ''
   , 
   first fnt027 no-lock
   where fnt027.cliente  eq pc_cliente
     and fnt027.empresa  eq 1
     and fnt027.entidade eq anexos.nomeArquivo
   ,
   first fnt026 no-lock
   where fnt026.empresa eq 1
     and fnt026.codigo  eq fnt027.codigo
     and fnt026.cliente eq fnt027.cliente
     and fnt026.baixado eq no
     and fnt026.codigo  ne pi_codigo.
   Assign anexos.erro = 'Arquivo nao foi anexado pois pertence a '
                      + 'solicitacao ['
                      + String(fnt026.codigo)
                      + ']'.
   
end.
end procedure.

Procedure VerificarFonteExiste.
for each anexos
    where anexos.erro eq ''.
    if search(pc_diretorio + '/' + anexos.nomeArquivo) eq ? then 
       do.
          Assign anexos.erro = 'Arquivo nao foi anexado pois nao foi '
                             + 'encontrado ['
                             + pc_diretorio + '/' + anexos.nomeArquivo         
                             + ']'.
       end.
end.
return 'VerificarFonteExiste_ok'.
end procedure.

function getErroVerificacaoIncial returns char ().
def var vc_erro     as char.

vc_erro = ''.

find first fnt020 no-lock
     where fnt020.empresa = 1 
       and fnt020.login = pc_usuario no-error.
if not avail fnt020 then 
   find first fnt020 no-lock
        where fnt020.empresa = 1 
          and fnt020.tecnico = pc_usuario no-error.

if not avail fnt020 then 
   vc_erro = 'Usuario [' + pc_usuario + '] Nao cadastrado!'.
else if fnt020.ativo = no then 
   vc_erro = 'Usuario [' + pc_usuario + '] Nao esta ATIVO!'.
else if fnt020.ReferenteSetor then 
   vc_erro = 'Usuario [' + pc_usuario + '] eh uma referencia de setor!'.
else do.
     find first fnt021 no-lock
               where fnt021.cliente = pc_cliente no-error.
     if not avail fnt021 then do.
        find first t_Retorno no-error.
        if not avail t_Retorno then do.
           create t_Retorno.
           assign t_Retorno.resultado = 'SUCESSO'.
        end.
        t_Retorno.descricao = t_Retorno.descricao + '#' +
                             'Nao foi encontrado o cliente [' +
                                  pc_cliente + ']!'.
        assign vl_ok = no.
        leave.
     end.
     else do.
       if pc_diretorio = '' then  
          assign pc_diretorio = fnt021.dirfontes + '/dif'.
     end.

    run permitirManutencaoAnexos in this-procedure
        (Input 1 , input pi_codigo).
    if return-value ne 'permitirManutencaoAnexos_ok' then 
       vc_erro = getDescricaoReturnComErro(return-value).
    else do.   
       find first fnt026 no-lock
            where fnt026.empresa = 1
              and fnt026.codigo = pi_codigo no-error.
       if fnt026.cliente ne pc_cliente then 
          vc_erro = 'Cliente [' + pc_cliente + '] eh diferente do cliente da '
                  + 'solicitaca [' + String(pi_codigo) + ' - ' + fnt026.cliente
                  + '] Nao sera possivel anexar os fontes.'.
    End.    
end.
return vc_erro.   
end Function.

Procedure VerificarFonteBloqueadoParaEnvio.
for each anexos
   where anexos.erro eq ''
   ,
    each fnt047 no-lock
   where fnt047.empresa = 1        
     and fnt047.rotina  = trim(anexos.NomeArquivo)
     and fnt047.cliente = trim(pc_cliente)
     and fnt047.bloqueio= yes
     ,
   first fnt048 no-lock
   where fnt048.empresa = 1        
     and fnt048.cod-obs = fnt047.cod-obs
      break by fnt048.cod-obs
      .      
      anexos.erro = string(fnt047.bloqueio,
                           '** BLOQUEIO **/** ADVERTENCIA **') +
                           chr(10) +
                           fnt048.observacao
      .
End.
end Procedure.

Procedure AnexarFonteSolicitacao.
def var vc_diretorioDestino as char.

assign
     vc_DiretorioDestino = getDiretorioSSWCliente(input pc_cliente,
                                                 input pi_codigo).


for each anexos
   where anexos.erro eq ''.
   
   Run CriarRegistroDeAnexo in this-procedure
          (input 1,
           input pi_codigo,
           input anexos.NomeArquivo,
           input pc_diretorio,
           input vc_DiretorioDestino)
          .
   if return-value ne 'CriarRegistroDeAnexo_ok' then do.
      assign anexos.erro = getDescricaoReturnComErro(return-value).
      next.
   end.   
   
   run  CriarArquivoPastaSSW in this-procedure
        (input pc_diretorio,
         input vc_DiretorioDestino,
         input anexos.NomeArquivo).
   if return-value ne 'CriarArquivoPastaSSW_ok' then 
      do.
         assign anexos.erro = getDescricaoReturnComErro(return-value).
         Run DeletarRegistroDeAnexo in this-procedure
             (input 1,
              input pi_codigo,
              input anexos.NomeArquivo).
         if return-value ne 'DeletarRegistroDeAnexo_ok' then 
            do.
               anexos.erro = anexos.erro + chr(10) 
                           + getDescricaoReturnComErro(return-value).
               undo, next.
            end.  
         Next.   
      end.   
   if anexos.erro = '' then 
      Assign anexos.anexado = yes
             anexos.erro    = 'Anexado com Susseco'.   
         
end.
return 'AnexarFonteSolicitacao_ok'.

end procedure.

procedure criarocorrencia.
def var vl-ocorrencia as int.
def var vc_descricao  as char.


vc_descricao = 'Anexo de fontes via REDMINE:'
             + chr(10).
             
for each anexos.
    vc_descricao = vc_descricao 
                 + anexos.nomearquivo
                 + chr(10).
end.

   find first fnt026 no-lock
        where fnt026.empresa = 1
          and fnt026.codigo  = pi_codigo.
          
   find first fnt024 no-lock
        where fnt024.etapa begins '01'
        .

   find last fnt028 no-lock
       where fnt028.empresa eq fnt026.empresa
         and fnt028.codigo  eq fnt026.codigo
       no-error.

   if avail fnt028 then
      vl-ocorrencia = fnt028.ocorrencia.

   release fnt028.
   
   vl-ocorrencia = vl-ocorrencia + 1.

   create fnt028.
   assign
      fnt028.empresa        = fnt026.empresa 
      fnt028.codigo         = fnt026.codigo
      fnt028.ocorrencia     = vl-ocorrencia
      fnt028.data-inicio    = today
      fnt028.hora-inicio    = time
      fnt028.concluido      = yes
      fnt028.etapa          = fnt024.etapa
      fnt028.descricao      = vc_descricao
           .
            
   create fnt029.
   assign 
      fnt029.empresa            = fnt028.empresa
      fnt029.codigo             = fnt028.codigo
      fnt029.ocorrencia         = fnt028.ocorrencia
      fnt029.tecnico            = fnt020.tecnico
      fnt029.hora-inicio        = fnt028.hora-inicio
      fnt029.hora-final         = time
      fnt029.resp-pela-atividad = yes
      fnt029.tec-cadastrou      = 'skt501'
   .
   release fnt029.
   release fnt028.
   
end.

