/**
 * Created by Rafael on 06/05/2014.
 */

var videos = [];
var news = [];


$(document).ready(function () {

    $('#watch-later').tooltip();

//    $('#news-carousel').carousel({
//        interval: 2000
//    });
//
//
//    //este evento é despoletado quando a animação começa
//    $('#news_carousel').on('slide.bs.carousel', function () {
//        //id da posição seleccionada actualmente
//        obj = $("#news_carousel .active").attr('id');
//
//        var splitted_id = obj.split("_");
//        var id = splitted_id[splitted_id.length - 1]; //obtem o ID e normaliza-o para 0 até length-1
//
//        alert(id);
//    });
//
////    $('#myCarousel').on('slid.bs.carousel', function () {
////        // do something…
////    })

});


function init() {

    videos = $.getValues('/videos');
    news = $.getValues('/contents');

//    var obj = $('#watch-later');
//    obj.mouseenter(function () {
//        $('#watch-later').tooltip('show');
//    })
//        .mouseleave(function () {
//            $('#watch-later').tooltip('hide');
//        });


//   ACTIVADO DE NOVO  ##DESACTIVADO APENAS PARA EFEITOS DE TESTE: JA FUNCIONA!
    updateCurrentVideo();

//    $('#testeFeeds').load('/homepage/fetch_mail');

//   DESACTIVADO PARA EFEITOS DE TESTE!!!!!
    $('#testeFeeds').load('/homepage/feeds');

//    setInterval(function(){
//        $('#testeFeeds').load('/homepage/feeds');
//    }, 20000);

}

function watchLater(index) {
    var currElement;

    console.log("CA ESTOU EU CRL: " + index);

    //no caso do botão de agendar no topo da pagina inicial
    if (index == undefined)
        currElement = $.getValues('/current_videos')[0];

    // clicamos para agendar numa noticia (pagina inicial ou index das noticias)
    else {
        console.log("o indice NÃO é negativo!");
        var contents = $.getValues('/contents');
        currElement = contents[index-1];
        console.log(currElement);
    }

    var ind;

    if (currElement.content_type == "video") {
        var videoContent = news[videos[currElement.index - 1].content_id - 1];
        ind = videoContent.id;
        console.log("diz que é video!!")
    }
    else
        ind = currElement.id;

    if (index == null) {
        if (ind > 0) {
            $.ajax({
                url: "/bookmarked_contents",
                type: "POST",
                data: {content_id: ind},
                success: createAlertDiv()
            });
        }
    }
    else {
        if (ind > 0) {
            $.ajax({
                url: "/bookmarked_contents",
                type: "POST",
                data: {content_id: ind}
            });
        }
    }
}

function createAlertDiv() {

    toShow = '<div class="col-md-2"></div>' +
        '<div class="col-md-8 alert alert-success" role="alert" style="margin-bottom: 0px;">' +
        '<p>Conteúdo gravado com sucesso!</p>' +
        '</div><div class="col-md-2"></div>';

    $("#bookmark-message-alert").removeClass('animated fadeOutUp');
    $("#bookmark-message-alert").addClass('animated fadeInDown');
    $("#bookmark-message-alert").append(toShow);

    setTimeout(function () { //timeout para garantir que o novo texto aparece entre os dois fades
        $("#bookmark-message-alert").removeClass('animated fadeInDown');
        $("#bookmark-message-alert").addClass('animated fadeOutUp');

    }, 3000);

    setTimeout(function () {
//        alert("isto só devia vir dps");
        $("#bookmark-message-alert").empty();
    }, 3500);
}


//ALTERAR O TIMEOUT PARA 1 OU 2 SEGUNDOS
//VERIFICAR SE A PROXIMA INFO É IGUAL À QUE LÁ ESTÁ
//TOMAR ATENÇAO AO CASO EM QUE A TV NÃO ESTÁ LIGADA E O SITE ESTÁ - ESTE PONTO ESTÁ FEITO
//ESTE ULTIMO CASO DEVE APRESENTAR: TV DESLIGADA
function updateCurrentVideo() {

//    var previous_video = -1;

    interval_ID = setInterval(function () {

        var onpage = $('#bookmarkText').css('display');
        if (onpage != undefined) {


            //videos = vector de videos (json)
            //news = vector de conteudos (json)
            var contents = $.getValues('/current_videos');
            var curr = contents[0];

            //a tv está ligada, entramos aqui
            if (curr.index != 0) {

                var curr_video;
                if (curr.content_type == 'video') {
                    curr_video = news[videos[curr.index - 1].content_id - 1];
                    //var curr_video = videos[curr.index - 1];

                    $("#bookmarkText > span").empty();
                    $("#bookmarkText > span").append(curr_video.title);
                }
                //Se for imagem
                else {
                    curr_video = news[curr.index - 1];

                    $("#bookmarkText > span").empty();
                    $("#bookmarkText > span").append(curr_video.title);
                }
            }
            else {
                $("#bookmarkText > span").empty();
                $("#bookmarkText > span").append("A TV está desligada.");
            }
        }
    }, 5000);
}


//função que adapta uma div à imagem que tiver dentro dela
function resizeText() {
    $(".topContent").width($(".topContent > img").width());
}


jQuery.extend({
    getValues: function (url) {
        var result = null;
        $.ajax({
            url: url,
            type: 'get',
            dataType: 'json',
            async: false,
            cache: false,
            success: function (data) {
                result = data;
            }
        });
        return result;
    }
});

function populateHeadlineDescription() {
    var interval_ID;
    var obj;
    var contents = $.getValues('/contents');

    // o intervalo serve para obter o id correcto, senão dava o anterior
    interval_ID = setInterval(function () {

        //id da posição seleccionada actualmente
        obj = $("#news_carousel .active").attr('id');

        var splitted_id = obj.split("_");
        var id = splitted_id[splitted_id.length - 1]; //obtem o ID e normaliza-o para 0 até length-1

        var toChange = $("#sideDescription > h2");
        toChange.empty();
        toChange.append(contents[id].title);

        toChange = $("#description-text");
        toChange.empty();
        toChange.append(contents[id].description);

        clearInterval(interval_ID);
    }, 650);
}