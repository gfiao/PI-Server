/**
 * Created by Rafael on 06/05/2014.
 */

function Weekday(shortName, portugueseName) {
    this.shortName = shortName;
    this.portugueseName = portugueseName;
}

var weekdays = new Array(new Weekday("Sun", "Domingo"), new Weekday("Mon", "Segunda"), new Weekday("Tue", "Terça"),
    new Weekday("Wed", "Quarta"), new Weekday("Thu", "Quinta"), new Weekday("Fri", "Sexta"), new Weekday("Sat", "Sábado"));

var months = new Array("Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro",
    "Outubro", "Novembro", "Dezembro");

var footer_text = "Isto é um exemplo. Tou mesmo a ver que isto vai sair" +
    " fora do ecrã";
var restaurant = new Array("Cantina", "SpotBar", "Teresa");
var ementa_cantina = new Array("Sopa de couve", "Frango do deserto", "Massa com cenas", "Salada de frutas");
var ementa_spot = new Array("Sopa de nabiças", "Strogonoff", "Massa à bolonhesa", "Caril de frango");
var ementa_teresa = new Array("Massa com natas", "Bitoque", "Pataniscas com arroz", "Bacalhau à brás");
var ementas = new Array(ementa_cantina, ementa_spot, ementa_teresa);
var headline_description = new Array("Isto é o titulo da noticia 1, daquele bacano de barbas que vem cá",
    "Olha, diz que o Gui é um mariconço e gosta de linhas redondas",
    "Mais uma noticia, não sei para que é que queremos tantas noticias",
    "Esta é que é mesmo a ultima noticia, caprichos do Leogay");

var globalCounter;
var countRestaurant;
var countPublicTrans;
var countMeteo;
var siteCantina = "http://sas.unl.pt/cantina";
var firstTimeCantina;
var today;

//function handleFiles(files) {
//    //Retrieve the first (and only!) File from the FileList object
//    var file = files[0];
//    alert("hehe");
//    console.log(file);
//
//    if (file) {
//        var r = new FileReader();
//        r.onload = function(e) {
//            var contents = e.target.result;
//            alert( "Got the file.n"
//                    +"name: " + file.name + "n"
//                    +"type: " + file.type + "n"
//                    +"size: " + file.size + " bytesn"
//                    + "starts with: " + contents.substr(1, contents.indexOf("n"))
//            );
//        }
//        r.readAsText(file);
//    } else {
//        alert("Failed to load file");
//    }
//}


function init() {
    globalCounter = 0;
    countRestaurant = 0;
    countPublicTrans = 0;
    countMeteo = 0;
    firstTimeCantina = true;
//    document.getElementById('fileInput').addEventListener('onclick', handleFiles, false);
//    console.log(document.getElementById("fileInput"));

//    readSingleFile();
    updateTime();
    updateDate();
//    getEmenta();
//    animatePanel();
    // animateFooter();
}


function populateHeadlineDescription() {
    var interval_ID;
    var obj;

    interval_ID = setInterval(function () {

        //id da posição seleccionada actualmente
        obj = $("#news_carousel .active").attr('id');

        var splitted_id = obj.split("_");
        var id = splitted_id[splitted_id.length - 1] - 1; //obtem o ID e normaliza-o para 0 até length-1

        var toChange = $("#sideDescription > h2");
        toChange.empty();
        toChange.append(headline_description[id]);

        clearInterval(interval_ID);
    }, 650);

}


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
//JÁ FUNCIONA. FADE IN/OUT NAO DESLIZANTE
function animatePanel() {
    var intervalID;
    var toShow;

    //0 -> ementa; 1 -> transportes; 2 -> tempo
//        var modulus = globalCounter % 3;

    intervalID = setInterval(function () {

        //recomeça de novo
        if (globalCounter == 100)
            globalCounter = 0;

        //obtem o conteudo a mostrar
        toShow = fetchContent();

        $("#right-panel-middle").animate({
            left: '1500px',
            opacity: '0',
            height: '406px' //alterar este valor conforme o tamanho da div
        }, "slow");
        setTimeout(function () { //timeout para garantir que o novo texto aparece entre os dois fades
            $("#right-panel-middle").empty();
            $("#right-panel-middle").append(toShow);
//            $("#animated-panel").append("CENAS CENAS CENAS CENAS CENAS CENAS CENAS CENAS CENAS CENAS CENAS");
        }, 650);
        $("#right-panel-middle").animate({
            left: '0px',
            opacity: '1',
            height: '406px'
        }, "slow");

        //não deverá ser usado, queremos que a animaçao do painel esteja sempre a correr
//        if (stopInterval) {
//            clearInterval(intervalID);
//            stopInterval = false;
//            console.log("hehehehe   ", globalCounter);
//        }

    }, 5000); //time in ms

    //QUALQUER CODIGO QUE VENHA APOS O FIM DO SET_INTERVAL,
    //É EXECUTADO LOGO AO INICIO. QUANDO O SET_INTERVAL CHEGA AO FIM,
    //OU SEJA, É CHAMADO O CLEAR_INTERVAL, O MÉTODO TERMINA, NÃO CHEGANDO
    //A ESTE COMENTARIO NESSA ALTURA
}


//animar o rodape
//com o tamanho da letra actual, o limite são 77 caracteres!!
function animateFooter() {
    var count = 0;
    var intervalID;

    intervalID = setInterval(function () {

        //exemplo 1 - usando slideup e slidedown
        $("#news-container").slideUp();
        setTimeout(function () { //timeout para garantir que o novo texto aparece entre o slideup e o slidedown
            $("#news-container").empty();
            $("#news-container").append('<p>' + footer_text + '</p>');
        }, 300);
        $("#news-container").slideDown();

        count++;

        //apenas para não correr infinitamente, remover isto no final
        if (count == 12)
            clearInterval(intervalID);

    }, 5000); //alterar este valor para aumentar/diminuir o tempo que cada frase é mostrada
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

function createCORSRequest(method, url) {
    var xhr = new XMLHttpRequest();
    if ("withCredentials" in xhr) {

        // Check if the XMLHttpRequest object has a "withCredentials" property.
        // "withCredentials" only exists on XMLHTTPRequest2 objects.
        xhr.open(method, url, true);

    } else {

        // Otherwise, CORS is not supported by the browser.
        xhr = null;

    }
    return xhr;
}

function getEmenta() {

    //a cada iteração, mostra a ementa de cada um dos restaurantes
    var index = countRestaurant % 3;
    var lunch_place = restaurant[index];
    var ementaContent = ementas[index];

//    alert("antes de entrar");

    if (firstTimeCantina) {

//        var content = "";
//        File file =
//
//        var reader = new FileReader();
//
//        reader.onload = function(e) {
//            content = reader.result;
//        }
//
//        reader.readAsText("/public/ementas/cantinaAlmoco.txt");


//        $.ajax({
//            url: "http://localhost:3000/public/ementas/cantinaAlmoco.txt",
//            type: "GET",
//            dataType: "jsonp",
//            success: function(data) {
////                content = data;
//                alert("sucesso: " + data.length + " linhas retornadas");
//            }
//        });


//        $.get(siteCantina, function (data) {
//            alert("hehehehe");
//            var lines = data.split("\r\n");
//            alert(lines.length);
//
////            $.each(lines, function (n, elem) {
////                var cont = elem.split(" ");
////                info[n] = cont[1];
////            });
////            if (count == 0)
////                createMap();
////            count++;
//        }, 'html');

//        $.ajax({
//
//            // The 'type' property sets the HTTP method.
//            // A value of 'PUT' or 'DELETE' will trigger a preflight request.
//            type: 'GET',
//
//            // The URL to make the request to.
//            url: 'http://sas.unl.pt/cantina',
//
//            // The 'contentType' property sets the 'Content-Type' header.
//            // The JQuery default for this property is
//            // 'application/x-www-form-urlencoded; charset=UTF-8', which does not trigger
//            // a preflight. If you set this value to anything other than
//            // application/x-www-form-urlencoded, multipart/form-data, or text/plain,
//            // you will trigger a preflight request.
//            contentType: 'text/html',
//
//            xhrFields: {
//                // The 'xhrFields' property sets additional fields on the XMLHttpRequest.
//                // This can be used to set the 'withCredentials' property.
//                // Set the value to 'true' if you'd like to pass cookies to the server.
//                // If this is enabled, your server must respond with the header
//                // 'Access-Control-Allow-Credentials: true'.
//                withCredentials: false
//            },
//
//            headers: {
//                // Set any custom headers here.
//                // If you set any non-simple headers, your server must include these
//                // headers in the 'Access-Control-Allow-Headers' response header.
//            },
//
//            success: function() {
//                // Here's where you handle a successful response.
//                alert("Success");
//            },
//
//            error: function() {
//                // Here's where you handle an error response.
//                // Note that if the error was due to a CORS issue,
//                // this function will still fire, but there won't be any additional
//                // information about the error.
//                alert("Error");
//            }
//        });


//        // All HTML5 Rocks properties support CORS.
//        var url = 'http://sas.unl.pt/cantina';
//
//        var xhr = createCORSRequest('GET', url);
//        if (!xhr) {
//            alert('CORS not supported');
//            return;
//        }
//
//        // Response handlers.
//        xhr.onload = function() {
//            var text = xhr.responseText;
//            var title = getTitle(text);
//            alert('Response from CORS request to ' + url + ': ' + title);
//        };
//
//        xhr.onerror = function() {
//            alert('Woops, there was an error making the request.');
//        };
//
//        xhr.send();

        firstTimeCantina = false;
    }


    var content = '<h2>' + lunch_place + '</h2><ul id="ementaList">';


    $.each(ementaContent, function (i, item) {
        content += '<li>' + item + '</li>';
    });

    content += '</ul>';
    countRestaurant++;

    //chegou à ultima ementa, reinicializa o counter e incrementa o counter global
    if (countRestaurant == ementas.length) {
//        getNewContent = true;
        countRestaurant = 0;
        globalCounter++;
    }

    return content;
}

// Helper method to parse the title tag from the response.
function getTitle(text) {
    return text.match('<title>(.*)?</title>')[1];
}

function getPublicTrans() {
    var content = '<h2>' + "TRANSPORTES" + '</h2>';

    globalCounter++;
    return content;
}

function getMeteo() {
    var content = '<h2>' + "METEO" + '</h2>';

    globalCounter++;
    return content;
}

//função que adapta uma div à imagem que tiver dentro dela
function resizeText() {
    $(".topContent").width($(".topContent > img").width());
}

//actualiza a data da TV
function updateDate() {
    today = new Date();

    var fullDate = today.toLocaleDateString().split("/"); //format: dia/mes/ano

    var weekday = today.toString().split(" ")[0];
    var day = fullDate[0];
    var month = fullDate[1];
//    var year = fullDate[2];

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


/**************************BUSCAR NOTICIAS A BD POR REST*****************/

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

var rodape = $.getValues('/contents')
console.log(rodape);

var titles = [];
function getTitles() {
    $.each(rodape, function (i, obj) {
        titles[i] = obj.title;
    });
}
getTitles();

/************************************************/
/********INSERIR PLAYLIST DE VIDEOS NA TV********/
/************************************************/


var videos = [];

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
        playerVars: { 'autoplay': 1, 'showinfo': 0, 'rel': 0, 'controls': 0, 'modestbranding': 1},
        events: {
            'onReady': onPlayerReady,
            'onStateChange': onPlayerStateChange
        }
    });
}

var nVid = 0;
var codigos = [];
// 4. The API will call this function when the video player is ready.
function onPlayerReady(event) {
    $.each(videos, function (i, video) {
        codigos[i] = video.link.split('/')[4];
    });

    player.loadPlaylist(codigos, nVid, 0);
    event.target.playVideo();
}

// 5. The API calls this function when the player's state changes.
var done = false;
function onPlayerStateChange(event) {
    if (event.data == YT.PlayerState.ENDED) {
        if (nVid == codigos.length - 1)
            nVid = 0;
        else
            nVid++;
        onPlayerReady(event); //Isto funciona, mas deixa a pagina um pouco lenta ao inicio
    }
}