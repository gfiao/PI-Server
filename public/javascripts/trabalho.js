/**
 * Created by Rafael on 06/05/2014.
 */

var videos = [];

function init() {
//    populateHeadlineDescription();
    videos = $.getValues('/videos');
//    console.log(videos);

//   ACTIVADO DE NOVO  ##DESACTIVADO APENAS PARA EFEITOS DE TESTE: JA FUNCIONA!
    updateCurrentVideo();

//    $("#testeFeeds").load("http://www.eurogamer.pt/?format=rss&platform=PS3 <p>", function () {
//        alert("The last 25 entries in the feed have been loaded");
//    });


}

function watchLater() {
    var currElement = $.getValues('/current_videos')[0];
    var ind = currElement.index;

    if (ind > 0) {
        $.ajax({
            url: "/bookmarked_contents",
            type: "POST",
            data: {content_id: ind},
            success: alert("Sucessos caralho!")
        });
    }
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

            var contents = $.getValues('/current_videos');
            var curr = contents[0];

            //a tv está ligada, entramos aqui
            if (curr.index != 0) {

                var curr_video = videos[curr.index - 1];

                $("#bookmarkText > h4").empty();
                $("#bookmarkText > h4").append(curr_video.link);
            }
            else {
                $("#bookmarkText > h4").empty();
                $("#bookmarkText > h4").append("A TV está desligada");
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


//function alertTemp() {
//    alert("hehehe isto devia estar no site");
//}
//
//module.exports.alertTemp = alertTemp;

function populateHeadlineDescription() {
    var interval_ID;
    var obj;
    var contents = $.getValues('/contents');

    interval_ID = setInterval(function () {

        //id da posição seleccionada actualmente
        obj = $("#news_carousel .active").attr('id');

        var splitted_id = obj.split("_");
        var id = splitted_id[splitted_id.length - 1]; //obtem o ID e normaliza-o para 0 até length-1

        var toChange = $("#sideDescription > h2");
        toChange.empty();
        toChange.append(contents[id].title);

        toChange = $("#sideDescription > p");
        toChange.empty();
        toChange.append(contents[id].description);

        clearInterval(interval_ID);
    }, 650);

}