$(document).ready(function() {
    $('#arquivosservertable').dataTable( {
        "search": {
            "regex": true
        },
        "language": {
            "loadingRecords": "Por favor aguarde - Carregando...",
            "processing": "Carregando..",
            "search": "Filtrar arquivos:",
            "emptyTable": "Nenhum arquivo encontrado",
            "info": "Apresentando _START_ a _END_ de _TOTAL_ arquvios",
            "infoEmpty":"Nada para apresentar",
            "zeroRecords": "Nenhum arquivo para apresentar",
            "lengthMenu": 'Apresentar <select>'+
            '<option value="10">10</option>'+
            '<option value="20">20</option>'+
            '<option value="30">30</option>'+
            '<option value="40">40</option>'+
            '<option value="50">50</option>'+
            '<option value="-1">Todos</option>'+
            '</select> arquivos',
            "paginate": {
                "first":"Primeira p&aacute;",
                "last":"&Uacute;ltimo",
                "next": "Pr&oacute;xima p&aacute;gina",
                "previous": "P&aacute;gina anterior"
            }
        }
    } )

    var table = $('#arquivosservertable').DataTable();

    $('#arquivosservertable tbody').on( 'click', 'tr', function () {
        $(this).toggleClass('selected');
        contarSelecionados();
    } );

    contarSelecionados();
} );

function selecionarTudoPagina(){
    $('#arquivosservertable').find('tbody > tr').each(function() {
        if ($(this).hasClass('selected')) {

        } else {
            $(this).toggleClass('selected');
        }
    });
    contarSelecionados();
}
function limparSelecaoPagina(){
    $('#arquivosservertable').find('tbody > tr').each(function() {
        if ($(this).hasClass('selected')) {
            $(this).toggleClass('selected');
        } else {

        }
    });
    contarSelecionados();
}

function contarSelecionados(){
    var qtd = $('#arquivosservertable').DataTable().rows('.selected').data().length;
    var botaoRemover = document.getElementById("arquivosRemoverButton");
    var botaoAnexar = document.getElementById("anexarbutton");
    $('#qtdSelecionadaField').val(qtd +' arquivo(s) selecionado(s)');

   if ( qtd > 0 ) {
       if (botaoRemover != null){
           botaoRemover.removeAttribute("disabled");
       }
       if (botaoAnexar != null) {
           botaoAnexar.removeAttribute("disabled");
       }
   } else {
       if (botaoRemover != null){
           botaoRemover.setAttribute("disabled","disabled");
       }
       if (botaoAnexar != null) {
           botaoAnexar.setAttribute("disabled","disabled");
       }
   }

}

