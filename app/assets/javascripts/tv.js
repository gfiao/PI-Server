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


//var ementa_spot = new Array("Sopa de nabiças", "Strogonoff", "Massa à bolonhesa", "Caril de frango");
//var ementa_teresa = new Array("Massa com natas", "Bitoque", "Pataniscas com arroz", "Bacalhau à brás");
//var ementa_cantina = []; //vai buscar a ementa à base de dados, atraves de um pedido rest

var ementasAlmoco = new Array(3); //em cada posição vamos ter um array com as ementas de almoço para cada restaurante
var ementasJantar = [];
var restaurants = ["Cantina", "Casa do Pessoal", "My Spot Bar"]; //vai ter o nome de cada restaurante

var globalCounter;
var globalCounter2;
var countRestaurant;
var countPublicTrans;
var countMeteo;
var countFreeClassrooms;
var counthHighscores;
var firstTimeCantina;
var firstTimeWeather;
var footerNews;
var today;
var currVideoIndex = 0; //indica o indice do video que esta a correr de momento
var videosAppended = true;

var minute;
var hour;

$(document).ready(function () {

    if (videosAppended) {

        appendVideos();
        videosAppended = false;
    }

});


function start() {
    globalCounter = 0;
    globalCounter2 = 0;
    countRestaurant = 0;
    countPublicTrans = 0;
    countMeteo = 0;
    countFreeClassrooms = 0;
    counthHighscores = 0;
    footerNews = [];
    firstTimeCantina = true;
    firstTimeWeather = true;

    //envia a info do primeiro video para a tv
    currentVideoToHtml();

    updateTime();
    updateDate();
    fetchFooterNews();
    createFooter();
    animatePanel();
    animatePanel2();
//    getFreeClassrooms();

    getCurrentVideo();
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

jQuery.extend({
    getValuesParams: function (url, admin) {
        var result = null;
        $.ajax({
            url: url,
            type: 'get',
            dataType: 'json',
            async: false,
            cache: false,
            data: {type: admin},
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
            $('#toAnimate').addClass('fadeInRight');
        }, 650);

    }, /*18000*/ 5000); //time in ms

    //QUALQUER CODIGO QUE VENHA APOS O FIM DO SET_INTERVAL,
    //É EXECUTADO LOGO AO INICIO. QUANDO O SET_INTERVAL CHEGA AO FIM,
    //OU SEJA, É CHAMADO O CLEAR_INTERVAL, O MÉTODO TERMINA, NÃO CHEGANDO
    //A ESTE COMENTARIO NESSA ALTURA
}

function animatePanel2() {
    var intervalID;
    var toShow;

    intervalID = setInterval(function () {

        //recomeça de novo
        if (globalCounter2 == 100)
            globalCounter2 = 0;

        //obtem o conteudo a mostrar
        toShow = fetchContent2();

        $('#toAnimate2').removeClass('fadeInRight');
        $('#toAnimate2').addClass('animated fadeOutRight');

        setTimeout(function () { //timeout para garantir que o novo texto aparece entre os dois fades
            $("#toAnimate2").empty();
            $("#toAnimate2").append(toShow);
            $('#toAnimate2').removeClass('fadeOutRight');
            $('#toAnimate2').addClass('fadeInRight');
        }, 650);

    }, /*18000*/ 5000); //time in ms

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

//FUNÇAO QUE USA OS PARAMETROS DA PRIORIDADE
function fetchContent2() {
    if ((globalCounter2 % 3) == 0)
        return getFreeClassrooms();

    else
        return getHighscores();
}

//passar parametro para indicar se é almoço ou jantar
//Já trata ementas de outros restaurantes, nao apenas da cantina
function populateMenu() {

    //conteudo obtido da base de dados
    var menu = $.getValues('/menus');

    var counters = [0, 0, 0];

    // de seguida verifica se a entrada é para almoço (de momento só funciona para almoço)
    // se for, adiciona-a ao array de ementas do respectivo restaurante
    $.each(menu, function (i, el) {

        var rest = el.restaurant;
        var index = restaurants.indexOf(rest);
        var count;

        //para o caso de aparecerem ementas que não nos interessam mostrar na TV
        //de momento, apenas mostramos CANTINA, MY-SPOT-BAR e CASA-DO-PESSOAL
        if (index != -1) {

            count = counters[index]; //o numero de entrada para o restaurante da entrada actual

            // inicializa os vectores das ementas
            if (count == 0) {
                ementasAlmoco[index] = [];
            }

            if (el.meal == "almoço") {
                ementasAlmoco[index].push(el.dish);
                counters[index]++;
            }
            else if (el.meal == "jantar") {
                ementasJantar.push(el.dish);
            }
        }

    });

//    console.log(restaurants);
//    console.log(ementasAlmoco);
}

function getEmenta() {

    if (firstTimeCantina) {
        populateMenu();
        firstTimeCantina = false;
    }

    var lunch_place;
    var ementaContent;

    // a hora é menor que 18:00, mostramos a ementa do almoço
    if (hour < 18) {

        //a cada iteração, mostra a ementa de cada um dos restaurantes
        var index = countRestaurant % 3;
        lunch_place = restaurants[index];
        ementaContent = ementasAlmoco[index];

        var content = '<h2 style="font-size: 140%">' + lunch_place + '</h2><ul id="ementaList">';

        $.each(ementaContent, function (i, item) {
            content += '<li style="font-size: 90%">' + item + '</li>';
        });

        content += '</ul>';
        countRestaurant++;

        //chegou à ultima ementa, reinicializa o counter e incrementa o counter global
        if (countRestaurant == ementasAlmoco.length) {
            countRestaurant = 0;
            globalCounter++;
        }
    }
    else {
        lunch_place = "Cantina - Jantar";
        ementaContent = ementasJantar;

        var content = '<h2 style="font-size: 140%">' + lunch_place + '</h2><ul id="ementaList">';

        $.each(ementaContent, function (i, item) {
            content += '<li style="font-size: 90%">' + item + '</li>';
        });

        content += '</ul>';

        countRestaurant = 0;
        globalCounter++;
    }

    return content;
}


//Objecto a ser inserido na TV
function Transport(carreira, origin, destination, hour, minute) {
    this.carreira = carreira;
    this.origin = origin;
    this.destination = destination;
    this.hour = hour;
    this.minute = minute;
}
function getPublicTrans() {
    var transports = $.getValues('/transports');
    var transportsTST = [];
    var transportsMTS = [];

    for (var i = 0; i < transports.length; i++) {
        var schedules = transports[i].transport_hours;
        var hours = transports[i].hours;
        if (schedules.length != 0)
            for (var j = 0; j < hours.length; j++) {
                if (transports[i].carreira == 0)
                    transportsMTS.push(new Transport(transports[i].carreira, transports[i].origin, transports[i].destination
                        , hours[j].hour, hours[j].minute));
                else
                    transportsTST.push(new Transport(transports[i].carreira, transports[i].origin, transports[i].destination
                        , hours[j].hour, hours[j].minute));
            }
    }


    var content = '<h2 style="font-size: 140%">' + "Próximos transportes" + '</h2>';

    content += '<div style="padding-left: 3%"><p>MTS:</p>';
    var counter = 0;

    var transTime = new Date(); //hora do transporte
    var currentTime = new Date(); //hora actual
    currentTime.setHours(hour);
    currentTime.setMinutes(minute);

    for (var i = 0; i < transportsMTS.length; i++) {
        transTime.setHours(transportsMTS[i].hour);
        transTime.setMinutes(transportsMTS[i].minute);
        var diff = ((transTime - currentTime) / 1000) / 60; //diff in minutes

        if (diff <= 30 && diff > 0) {
            if (transportsMTS[i].minute == 2 || transportsMTS[i].minute == 5 || transportsMTS[i].minute == 7 || transportsMTS[i].minute == 0)
                content += '<span class="transport-span">' + transportsMTS[i].hour + ':0' + transportsMTS[i].minute + '</span>';
            else
                content += '<span class="transport-span">' + transportsMTS[i].hour + ':' + transportsMTS[i].minute + '</span>';
            if (counter != 2) content += '|';
            if (counter == 4) break;
            counter++;
        }
    }
    if (counter == 0)
        content += '<p style="text-align: center">Não há transportes para mostrar.</p>';
    content += '</div></br>';

    currentTime.setHours(hour);
    currentTime.setMinutes(minute);

    counter = 0;
    content += '<div style="padding-left: 3%"><p>TST:</p>';
    for (var i = 0; i < transportsTST.length; i++) {
        transTime.setHours(transportsTST[i].hour);
        transTime.setMinutes(transportsTST[i].minute);
        diff = ((transTime - currentTime) / 1000) / 60; //diff in minutes

        if (diff <= 30 && diff > 0) {

            if (transportsTST[i].minute == 2 || transportsTST[i].minute == 5 || transportsTST[i].minute == 7 || transportsTST[i].minute == 0)

                content += '<p style="padding-left:6%;">' + transportsTST[i].carreira +
                    '  ' + transportsTST[i].destination + ' - ' +
                    transportsTST[i].hour + ':0' + transportsTST[i].minute + '</p>';
            else
                content += '<p style="padding-left:6%;">' + transportsTST[i].carreira +
                    '  ' + transportsTST[i].destination + ' - ' +
                    transportsTST[i].hour + ':' + transportsTST[i].minute + '</p>';

            if (counter == 2) break;
            counter++;
        }
    }
    if (counter == 0)
        content += '<p style="text-align: center">Não há transportes para mostrar.</p>';
    content += '</div>';


    globalCounter++;
    return content;
}

var weather;

function getMeteo() {

    if (firstTimeWeather) {
        weather = $.getValues('/weathers');
        firstTimeWeather = false;
    }

    if (weather[0].description = 'Predominantemente Nublado')
        weather[0].description = 'Muito Nublado';

    var content = '<h1 style="text-align: center;">Meteorologia</h1>';

    content += '<h1 style=" text-align: center">Almada</h1>';

    content += '<div style="text-align: center;font-size: 130%">' + weather[0].description + '  ' +
        '<img src="' + weather[0].image_url + '"></div></br>';
    content += '<div>';
    content += '<span class="meteo-span">Min:</span>';
    content += '<span class="meteo-span">Max:</span>';
    content += '</br>';
    content += '<span class="meteo-span"><b>' + weather[0].min_temp + 'º</b></span>';
    content += '<span class="meteo-span"><b>' + weather[0].max_temp + 'º</b></span>';
    content += '</div>';

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

    minute = today.getMinutes();
    hour = today.getHours();

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
var imagens = [];

videos = $.getValues('/videos');
imagens = $.getValues('/contents');

function appendVideos() {

    $.each(videos, function (i, video) {
        var caption = '';

        for (var j = 0; j < imagens.length; j++) {
            if (video.content_id == imagens[j].id)
                caption = imagens[j].title;
        }

        if (i == 0) {
            $('#tv-carousel').append('<div id = "video_' + i + '" class="item active itemsCar">' +
                '<iframe src="' + video.link + '?autoplay=0&controls=0&modestbranding=1&showinfo=0&loop=1" style="width: 100%; height:100%;"' +
                'frameborder = "0" ' +
                'width = 100%' +
                'height: 100%' +
                'enablejsapi="1"' +
                'allowfullscreen >' +
                ' </iframe>' +

                '<div class="carousel-caption" style="opacity: 0.8; background-color: #000000">' +
                '<h1>' + caption + '</h1>' +
                '</div>' +

                '</div>');
        }
        else
            $('#tv-carousel').append('<div id = "video_' + i + '" class="item itemsCar">' +
                '<iframe src="' + video.link + '?autoplay=0&controls=0&modestbranding=1&showinfo=0&loop=1" style="width: 100%; height:100%;" ' +
                'frameborder = "0" ' +
                'width = 100%' +
                'height: 100%' +
                'enablejsapi="1"' +
                'allowfullscreen >' +
                ' </iframe>' +

                '<div class="carousel-caption" style="opacity: 0.8; background-color: #000000">' +
                '<h1>' + caption + '</h1>' +
                '</div>' +

                '</div>');

    });

    $.each(imagens, function (i, imagem) {
        if (imagem.link_image != null)
            if (imagem.link_image.indexOf('http') >= 0) {
                $('#tv-carousel').append('<div id = "image_' + i + '" class="item itemsCar">' +
                    '<img src="' + imagem.link_image + '" style="width: 100%; height:100%;" > ' +
                    '<div class="carousel-caption" style="opacity: 0.8; background-color: #000000">' +
                    '<h1>' + imagem.title + '</h1>' +
                    '</div>' +
                    '</div>');
            }
            else {
                if (imagem.link_image != 'fct.gif')
                    $('#tv-carousel').append('<div id = "image_' + i + '" class="item itemsCar">' +
                        '<img src="/assets/' + imagem.link_image + '" style="width: 100%; height:100%;" > ' +
                        '<div class="carousel-caption" style="opacity: 0.8; background-color: #000000">' +
                        '<h1>' + imagem.title + '</h1>' +
                        '</div>' +
                        '</div>');
            }
    });

    $('#view-area').carousel({
        interval: 2000 // (12000 = o valor ideal) in milliseconds
    });
}

function getCurrentVideo() {

    $('#view-area').on('slid.bs.carousel', function () {

        var id = $(".active").attr("id");

        currVideoIndex = parseInt(id.split('_')[1]);
        currentVideoToHtml(id.split('_')[0]);
    });
}

//  2. This code loads the IFrame Player API code asynchronously.
var tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

// 3. This function creates an
//<iframe> (and YouTube player)
//    after the API code downloads.
var player;
function onYouTubeIframeAPIReady() {
    //  player = new YT.Player('view-area', {
    player = new YT.Player('activeVideo', {
//        height: '390',
//        width: '640',
//        videoId: videos[counterVid].link.split('/')[4], //retorna codigo dos videos
//        playerVars: { 'autoplay': 0, 'showinfo': 0, 'rel': 0, 'controls': 1, 'modestbranding': 1},
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

        currentVideoToHtml("video");
    }
}

function currentVideoToHtml(currentType) {
    $.ajax({
        url: '/homepage/index',
        data: {'currIndex': currVideoIndex + 1,
            'content_type': currentType},
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
    console.log(footerNews);
}

function createFooter() {

    intervalID = setInterval(function () {

        toShow = getFooterContent();

        $("#footer-category-tv p").removeClass('fadeInDown');
        $("#footer-category-tv p").addClass('fadeOutUp');

        $("#news-container").removeClass('fadeInDown');
        $("#news-container").addClass('fadeOutUp');

        setTimeout(function () { //timeout para garantir que o novo texto aparece entre os dois fades
            $("#footer-category-tv p").empty();
            $("#footer-category-tv p").append(toShow[0]);
            $("#footer-category-tv p").removeClass('fadeOutUp');
            $("#footer-category-tv p").addClass('animated fadeInDown');

            $("#news-container p").empty();
            $("#news-container p").append(toShow[1]);
            $("#news-container").removeClass('fadeOutUp');
            $("#news-container").addClass('animated fadeInDown');
        }, 650);

    }, 8000); //time in ms

}

function getFooterContent() {
    var content = footerNews[footerCounter];
    var toappend = [];

    toappend[0] = content.category;
    toappend[1] = content.news;

    if (footerCounter == footerNews.length - 1)
        footerCounter = 0;
    else
        footerCounter++;

    return toappend;
}

//Objecto a ser inserido na TV
function Free_classroom(building, classroom, from_time, to_time) {
    this.building = building;
    this.classroom = classroom;
    this.from_time = from_time;
    this.to_time = to_time;
}
function getFreeClassrooms() {
    var freeClassroomsToTV = [];
    var classrooms = $.getValues('/classrooms');

    for (var i = 0; i < classrooms.length; i++) {
        var free_classrooms = classrooms[i].free_classrooms;
        for (var j = 0; j < free_classrooms.length; j++) {
            var free = new Free_classroom(classrooms[i].building, classrooms[i].classroom,
                free_classrooms[j].from_time, free_classrooms[j].to_time);
            freeClassroomsToTV.push(free);
        }
    }

    //2014-06-20T10:26:01.901Z
    for (var i = 0; i < freeClassroomsToTV.length; i++) {
        var fromHour = freeClassroomsToTV[i].from_time.split('T')[1].split('.')[0].split(':');
        var toHour = freeClassroomsToTV[i].to_time.split('T')[1].split('.')[0].split(':');
        freeClassroomsToTV[i].from_time = fromHour[0] + ':' + fromHour[1];
        freeClassroomsToTV[i].to_time = toHour[0] + ':' + toHour[1];
    }

    var html = '<div id="divClassrooms"><p style="font-size: 300%; text-align: center">' +
        'Salas livres ' + freeClassroomsToTV[0].building + ':</p>';

    var counter = 0;
    for (var i = 0; i < freeClassroomsToTV.length; i++) {
        var classroomHour = freeClassroomsToTV[i].to_time.split(':')[0];
        var classroomMinute = freeClassroomsToTV[i].to_time.split(':')[1];

        //hora em q a sala acaba
        var classroomDate = new Date();
        classroomDate.setHours(classroomHour);
        classroomDate.setMinutes(classroomMinute);

        //data do sistema
        var systemDate = new Date();
        systemDate.setHours(hour);
        systemDate.setMinutes(minute);

        var diff = ((classroomDate - systemDate) / 1000) / 60;   //diff in minutes

        if (diff <= 120 && diff > 0) {
            html += '<p class="free-classrooms">' + freeClassroomsToTV[i].classroom
                + ' livre até às ' + freeClassroomsToTV[i].to_time + '</p>';
            if (counter == 2) break;
            counter++;
        }
    }
    html += '</div>';

    globalCounter2++;
//    $('#right-panel-bottom').append(html);
    return html;
}


//Objecto a ser inserido na TV
function Highscore(user_name, score) {
    this.user_name = user_name;
    this.score = score;
}
function getHighscores() {
    var scores = $.getValues('/scores');
    var users = $.getValuesParams('/users', 'admin');
    var scoresTV = [];
//    console.log(scores);
    for (var i = 0; i < 3; i++)
        for (var j = 0; j < users.length; j++)
            if (scores[i].user_id == users[j].id) {
                var score = new Highscore(users[j].name, scores[i].score);
                scoresTV.push(score);
                break;
            }
//    console.log(scoresTV);

    var html = '<div id=""><p style="font-size: 300%; text-align: center">' +
        'Melhores pontuações 2048:</p>';

    html += '<p class="scores">1º: ' + scoresTV[0].user_name + ' - ' + scoresTV[0].score + '</p>';
    html += '<p class="scores">2º: ' + scoresTV[1].user_name + ' - ' + scoresTV[1].score + '</p>';
    html += '<p class="scores">3º: ' + scoresTV[2].user_name + ' - ' + scoresTV[2].score + '</p>';
    html += '</div>';

    globalCounter2++;
    return html;

}