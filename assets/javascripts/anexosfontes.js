
$(document).ready(function() {
    $('#anexarbutton').click(function() {
        anexarSelecionados($('#issue_id').val());
    });
    $('#arquivosRemoverButton').click(function() {
        removerSelecionados($('#issue_id').val());
    });

});

function anexarSelecionados(issue_id){
    var arquivosEnviar = [];
    $('#arquivosservertable').DataTable().rows('.selected').data().
    each(function(currentValue, index){
        var arquivo =[];
        arquivo[0] = currentValue[0];
        arquivo[1] = currentValue[1];
        arquivo[2] = currentValue[2];
        arquivo[3] = currentValue[3];
        arquivo[4] = currentValue[4];
        arquivo[5] = currentValue[5];
        arquivo[6] = issue_id + "|";
        arquivosEnviar.push(arquivo);
    });
    $('#arquivosEnviar').val(arquivosEnviar);
}

function removerSelecionados(issue_id){
    var arquivosRemover = [];
    $('#arquivosservertable').DataTable().rows('.selected').data().
    each(function(currentValue, index){
        var arquivo =[];
        arquivo[0] = currentValue[0];
        arquivo[1] = issue_id + "|";
        arquivosRemover.push(arquivo);
    });
    $('#arquivosRemover').val(arquivosRemover);
}