/**
 * Created by Rafael on 06/05/2014.
 */

//$(document).ready(function () {
//
//    function CreateIndex() {
//        var ind = {currentIndex: 0};
//        return ind; //temp = {currentIndex: '0'};
//    }
//    window.CurrentVideo = CreateIndex();
////    console.log(window.CurrentVideo);
//    window.CurrentVideo.watch("currentIndex", function(id, oldval, newval) {
//        console.log("trabalho .js :  CurrentVideo." + id + " changed from " + oldval + " to " + newval );
//        return newval;
//    })
//});


function init() {
    populateHeadlineDescription();
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
    var contents = $.getValues('/contents')

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