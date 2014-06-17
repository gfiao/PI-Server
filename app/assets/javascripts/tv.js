/**
 * Created by Rafael on 28/05/2014.
 */

function Weekday(shortName, portugueseName) {
    this.shortName = shortName;
    this.portugueseName = portugueseName;
}

var weekdays = new Array(new Weekday("Sun", "Domingo"), new Weekday("Mon", "Segunda"), new Weekday("Tue", "Terça"),
    new Weekday("Wed", "Quarta"), new Weekday("Thu", "Quinta"), new Weekday("Fri", "Sexta"), new Weekday("Sat", "Sábado"));

var months = new Array("Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro",
    "Outubro", "Novembro", "Dezembro");


var restaurant = new Array("Cantina", "SpotBar", "Teresa");
var ementa_spot = new Array("Sopa de nabiças", "Strogonoff", "Massa à bolonhesa", "Caril de frango");
var ementa_teresa = new Array("Massa com natas", "Bitoque", "Pataniscas com arroz", "Bacalhau à brás");
var ementa_cantina = []; //vai buscar a ementa à base de dados, atraves de um pedido rest
var ementas = new Array(ementa_cantina, ementa_spot, ementa_teresa);


var globalCounter;
var countRestaurant;
var countPublicTrans;
var countMeteo;
var firstTimeCantina;
var footerNews;
var today;
var currVideoIndex = 0; //indica o indice do video que esta a correr de momento

//$(document).ready(function () {
//
////    var t = setInterval(function() {
//        console.log(window.CurrentVideo);
////        window.CurrentVideo.currentIndex = currVideoIndex;
////    }, 5000);
//
//
////    var obj = {value: 0};
////    obj.value = $('#right-panel-bottom').text;
////
////    obj.watch("value", function())
//
//});


function start() {
    globalCounter = 0;
    countRestaurant = 0;
    countPublicTrans = 0;
    countMeteo = 0;
    footerNews = [];
    firstTimeCantina = true;

//    var Mod = require('/trabalho');
//    Mod.alertTemp;

    //envia a info do primeiro video para a tv
    currentVideoToHtml();

    updateTime();
    updateDate();
    fetchFooterNews();
    createMarquee();
    animatePanel();
}


//require(['homepage'], function(badjoras) {
//
//    // jQuery loaded by foo module so free to use it
//    $('.button').on('click', function(e) {
//        badjoras.bar();
//        e.preventDefault();
//    });
//
//});


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


//IDEIA BASE:
//counter global de 0 a 99
//assim que chega a 99, passa novamente a 0
//a definição do que passa na TV será com base em prioridades
//HORA DE ALMOÇO (prioridade à ementa):
//counter < 69 -> ementa
//70 < counter < 94 -> tempo
//95 < counter < 99 -> transportes
//e assim sucessivamente para os outros periodos do dia


//animacao do painel lateral da ementa, meteo e transportes
//JÁ FUNCIONA.
function animatePanel() {
    var intervalID;
    var toShow;

    intervalID = setInterval(function () {

        //recomeça de novo
        if (globalCounter == 100)
            globalCounter = 0;

        //obtem o conteudo a mostrar
        toShow = fetchContent();

        $('#toAnimate').removeClass('fadeInRight');
        $('#toAnimate').addClass('animated fadeOutRight');

        setTimeout(function () { //timeout para garantir que o novo texto aparece entre os dois fades
            $("#toAnimate").empty();
            $("#toAnimate").append(toShow);
            $('#toAnimate').removeClass('fadeOutRight');
            $('#toAnimate').addClass('animated fadeInRight');
        }, 650);

    }, 5000); //time in ms

    //QUALQUER CODIGO QUE VENHA APOS O FIM DO SET_INTERVAL,
    //É EXECUTADO LOGO AO INICIO. QUANDO O SET_INTERVAL CHEGA AO FIM,
    //OU SEJA, É CHAMADO O CLEAR_INTERVAL, O MÉTODO TERMINA, NÃO CHEGANDO
    //A ESTE COMENTARIO NESSA ALTURA
}

//******************* FUNÇOES AUXILIARES *******************

//FUNÇAO QUE USA OS PARAMETROS DA PRIORIDADE
function fetchContent() {
    if ((globalCounter % 3) == 0)
        return getEmenta();

    else if ((globalCounter % 3) == 1)
        return getPublicTrans();

    else
        return getMeteo();
}

//passar parametro para indicar se é almoço ou jantar
function populateMenu() {

    //conteudo obtido da base de dados
    var menu = $.getValues('/menus');
    console.log(menu);
    var temp = [];

    $.each(menu, function (i, item) {
        if (item.meal == "almoco")
            temp[i] = item.dish;
    });

    ementas[0] = temp;
}

function getEmenta() {

    if (firstTimeCantina) {
        populateMenu();
        firstTimeCantina = false;
    }

    //a cada iteração, mostra a ementa de cada um dos restaurantes
    var index = countRestaurant % 3;
    var lunch_place = restaurant[index];
    var ementaContent = ementas[index];

    var content = '<h2>' + lunch_place + '</h2><ul id="ementaList">';


    $.each(ementaContent, function (i, item) {
        content += '<li>' + item + '</li>';
    });

    content += '</ul>';
    countRestaurant++;

    //chegou à ultima ementa, reinicializa o counter e incrementa o counter global
    if (countRestaurant == ementas.length) {
        countRestaurant = 0;
        globalCounter++;
    }

    return content;
}


function getPublicTrans() {
    var content = '<h2>' + "Transportes" + '</h2>';
    content += '<ul>TST: <li>158 - 16h30</li><li>246 - 17h00</li></ul>';
    content += '<ul>MTS: <li>16h30</li><li>17h00</li></ul>';

    globalCounter++;
    return content;
}


function getMeteo() {

    var weather = $.getValues('/weathers');
    console.log(weather);
    if (weather[0].description = 'Predominantemente Nublado')
        weather[0].description = 'Nublado';

    var content = '<h2 style="text-align: center">' + "Meteorologia" + '</h2>';
    content += '<h3 style="text-align: center">Almada</h3>';
    content += '<div style="text-align: center">' + weather[0].description +
        '<img width="" height="" src="' + weather[0].image_url + '"></div>';
    content += '<div style="text-align: center">Min: ' + weather[0].min_temp
        + ' Máx: ' + weather[0].max_temp + '</div>';

    globalCounter++;
    return content;
}

//actualiza a data da TV
function updateDate() {
    today = new Date();

    var fullDate = today.toLocaleDateString().split("/"); //format: dia/mes/ano

    var weekday = today.toString().split(" ")[0];
    var day = fullDate[0];
    var month = fullDate[1];

    var toDisplay = "";
    $.each(weekdays, function (i, elem) {
        if (elem.shortName == weekday)
            return toDisplay += elem.portugueseName;
    });

    toDisplay += ", " + day;
    toDisplay += " " + months[month - 1];

    $("#date-info p").text(toDisplay);
    t = setTimeout('updateDate()', 1800000); //é chamado a cada 30 min
}

//actualiza a hora da TV
function updateTime() {
    today = new Date();

    var minute = today.getMinutes();
    var hour = today.getHours();

    //add a zero in front of numbers < 10
    hour = checkTime(hour);
    minute = checkTime(minute);

    $("#hour-info p").text(hour + ":" + minute);
    t = setTimeout('updateTime()', 5000); //é chamado a cada 5 segundos
}

//funçao auxiliar para acrescentar um zero à esquerda caso o numero i
//seja menor que 10, para evitar que fique apenas um digito
function checkTime(i) {
    if (i < 10) {
        i = "0" + i;
    }
    return i;
}


/************************************************/
/********INSERIR PLAYLIST DE VIDEOS NA TV********/
/************************************************/

var videos = [];

videos = $.getValues('/videos');

//  2. This code loads the IFrame Player API code asynchronously.
var tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

// 3. This function creates an <iframe> (and YouTube player)
//    after the API code downloads.
var player;
function onYouTubeIframeAPIReady() {
    player = new YT.Player('view-area', {
        height: '390',
        width: '640',
        //videoId: videos[counterVid].link.split('/')[4], //retorna codigo dos videos
        playerVars: { 'autoplay': 0, 'showinfo': 0, 'rel': 0, 'controls': 1, 'modestbranding': 1},
        events: {
            'onReady': onPlayerReady,
            'onStateChange': onPlayerStateChange
        }
    });
}

var codigos = [];

// 4. The API will call this function when the video player is ready.
function onPlayerReady(event) {
    $.each(videos, function (i, video) {
        codigos[i] = video.link.split('/')[4];
    });

    player.loadPlaylist(codigos, 0, 0);
    player.playVideo();
    player.setLoop(true);
}

// 5. The API calls this function when the player's state changes.
function onPlayerStateChange(event) {
    if (event.data == YT.PlayerState.ENDED) {
        currVideoIndex++;
        if (currVideoIndex == videos.length)
            currVideoIndex = 0;

        currentVideoToHtml();
    }
}

function currentVideoToHtml() {
//    var obj = $("#bookmarkText h4");
//    obj.empty();
//    obj.append(currVideoIndex);

//    alert("hehehe");
//    alertAnotherPage();


//    $(function() {
//        window.hello();
//    });


    $.ajax({
        url: '/homepage/index',
        data: {'currIndex': currVideoIndex + 1},
        type: 'GET'
    });

}


/**************************BUSCAR NOTICIAS A BD POR REST*****************/
var rodape = $.getValues('/contents');
//console.log(rodape);

var titles = [];
function getTitles() {
    $.each(rodape, function (i, obj) {
        titles[i] = obj.title;
    });
}
getTitles();


//De momento apenas se obtem as noticias uma vez.
//Se a tabela que contem as noticias for alterada, essas noticias não serão mostradas no rodape
//Para obter a info várias vezes ao dia, usar setTimeout

var footerCounter = 0;

function fetchFooterNews() {
    footerNews = $.getValues('/footer_news');
//    console.log(footerNews);
}

function createMarquee() {
    $('#category p').append(footerNews[0].category);
    $('.news-container-scroll p').append(footerNews[0].news);
    $('.news-container-scroll')
        .bind('finished', populateMarquee)
        .marquee({
            duration: 5000
        });
    footerCounter++;
}

function populateMarquee() {
    var toappend = footerNews[footerCounter];

    $('#category p').empty();
    $('#category p').append(toappend.category);
    $('.news-container-scroll p').empty();
    $('.news-container-scroll p').append(toappend.news);

    if (footerCounter == footerNews.length - 1)
        footerCounter = 0;
    else
        footerCounter++;
}


/*
 * object.watch polyfill
 *
 * 2012-04-03
 *
 * By Eli Grey, http://eligrey.com
 * Public Domain.
 * NO WARRANTY EXPRESSED OR IMPLIED. USE AT YOUR OWN RISK.
 */

// object.watch
//if (!Object.prototype.watch) {
//    Object.defineProperty(Object.prototype, "watch", {
//        enumerable: false
//        , configurable: true
//        , writable: false
//        , value: function (prop, handler) {
//            var
//                oldval = this[prop]
//                , newval = oldval
//                , getter = function () {
//                    return newval;
//                }
//                , setter = function (val) {
//                    oldval = newval;
//                    return newval = handler.call(this, prop, oldval, val);
//                }
//                ;
//
//            if (delete this[prop]) { // can't watch constants
//                Object.defineProperty(this, prop, {
//                    get: getter
//                    , set: setter
//                    , enumerable: true
//                    , configurable: true
//                });
//            }
//        }
//    });
//}
//
//// object.unwatch
//if (!Object.prototype.unwatch) {
//    Object.defineProperty(Object.prototype, "unwatch", {
//        enumerable: false
//        , configurable: true
//        , writable: false
//        , value: function (prop) {
//            var val = this[prop];
//            delete this[prop]; // remove accessors
//            this[prop] = val;
//        }
//    });
//}
