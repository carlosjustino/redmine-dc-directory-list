$(document).ready(function() {
    $('#buscarfontesbutton').click(function() {
        $.blockUI({
            message: "<h1>Aguarde, Buscando fontes...</h1>",
            css: {
                border: 'none',
                padding: '15px',
                backgroundColor: '#000',
                '-webkit-border-radius': '10px',
                '-moz-border-radius': '10px',
                opacity: .5,
                color: '#fff'
            } });

        //setTimeout($.unblockUI, 5000);
    });

} );

