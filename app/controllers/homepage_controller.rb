class HomepageController < ApplicationController
  before_filter :update_video

  def update_video

    #estamos a aceder a partir da TV, actualizar o indice caso seja diferente do actual
    if !(params[:currIndex].nil?)
      # puts "fobiywvbefkf jobcwf qfb qefqbef qefb fq fqfwfqfbqi fjqhfbq fuiuhjnd qw   djkmsd bn "
      @video_id_table = CurrentVideo.first
      @currentVideo = params[:currIndex]
      @currentType = params[:content_type]

      puts "=================================================="
      puts @currentVideo

      if !(@video_id_table.index == @currentVideo)
        @video_id_table.index = @currentVideo
        @video_id_table.content_type = @currentType
        @video_id_table.save
        puts @video_id_table.index
      end
    else
    end
  end

  def feeds
    # 0 - I-ONLINE - EXCELENTE!! COM IMAGENS, TEXTO E TAL. é necessário algum parse ao texto. - http://feeds.feedburner.com/jornali?format=xml
    # 1 - DI eventos -  - http://www.di.fct.unl.pt/eventos/rss.xml
    # 2 - DI noticias -  - http://www.di.fct.unl.pt/noticias/rss.xml
    # 3 - Publico - é bom, mas nao mostra imagens! - http://feeds.feedburner.com/PublicoRSS?format=xml
    # 4 - ABola - é do catano, mostra imagens fixolas! -
    # 5 - JN - mais ou menos como o Publico, nao mostra imagens - http://feeds.jn.pt/JN-ULTIMAS
    # 6 - Expresso - muito pouca informação, nao vale a pena colocar - http://expresso.sapo.pt/static/rss/atualidade--arquivo_23412.xml
    # 7 - DN - outro que é parecido ao Publico.. - http://feeds.dn.pt/DN-Portugal
    # 8 - RTP - muitas noticias, algumas com imagens. problemas com acentos/cedilhas - http://www.rtp.pt/noticias/index.php?headline=204&visual=58
    # 9 - feedsdenoticias.blogspot - não presta, não vale uma piça, UMA PIÇA! - http://feeds.destakes.com/destakes/canal/imprensa?format=xml
    # 10 - Expresso Desporto -  - http://expresso.sapo.pt/static/rss/desporto_23414.xml
    # 11 - Blog BIBLIOTECA -  - http://feeds.feedburner.com/BlogueDaBibliotecaFct/unl?format=xml

    require 'rss'
    require 'nokogiri'

    # por enquanto apenas o jornal I, pois funciona bem. adicionar mais links mais tarde caso haja mais feeds bacanos hehe
    feeds = ["http://feeds.feedburner.com/jornali?format=xml", #0
             "http://www.di.fct.unl.pt/eventos/rss.xml", #1
             "http://www.di.fct.unl.pt/noticias/rss.xml", #2
             "http://feeds.feedburner.com/PublicoRSS?format=xml", #3
             "", #4
             "http://feeds.jn.pt/JN-ULTIMAS", #5
             "http://expresso.sapo.pt/static/rss/atualidade--arquivo_23412.xml", #6
             "http://feeds.dn.pt/DN-Portugal", #7
             "http://www.rtp.pt/noticias/index.php?headline=204&visual=58", #8
             "http://feeds.destakes.com/destakes/canal/imprensa?format=xml", #9
             "http://expresso.sapo.pt/static/rss/desporto_23414.xml", #10
             "http://feeds.feedburner.com/BlogueDaBibliotecaFct/unl?format=xml"] #11

    # alterar esta variavel consoante o feed que queremos usar
    selectedFeedIndex = 0

    rss = RSS::Parser.parse(feeds[selectedFeedIndex], false)
    puts "============================ INICIO FEEDS ==========================="

    puts rss.items
    # puts rss.title
    # puts rss.language
    # puts rss.lastBuildDate
    puts rss.image

    # puts "\n********** intervalo **********\n"

    rss.items.each do |item|
      puts "\n********** inicio de um item do feed **********"
      puts "#{item.pubDate} - #{item.title} (#{item.category})"

      puts item.description
      puts "\n"

      description = item.description

      # se for feed do jornal i, fazer parse da descriçao
      if selectedFeedIndex == 0
        doc = Nokogiri::HTML(description)

        # obter a imagem da noticia
        image = doc.css('img').map { |i| i['src'] } # Array of strings

        # obter a descrição
        description_div = doc.css('.field-type-text')[0]

        if !description_div.nil?
          description = description_div.css('.even')[0].text
        else
          description = item.title
        end


        # #obter texto da noticia
        text_div = doc.css('.field-type-text-with-summary')[0]
        paragraphs = text_div.css('.even')

        news_text = ""
        paragraphs.css('p').each do |paragraph|
          news_text.concat(paragraph.text + "\n")
        end

        puts "\n********** DESCRIÇÃO **********"
        puts "#{description}\n"

        puts "\n********** TEXTO DA NOTICIA **********"
        puts "#{paragraphs}\n"

        puts "\n********** IMAGEM **********"
        puts "#{image}\n"

        Content.create(title: item.title, link_image: image[0], description: description,
                       date: item.pubDate, views: 0, news_text: news_text, user_id: 1)

        puts "\n********** fim de um item do feed **********"

      # feed da biblioteca
      elsif selectedFeedIndex == 11
        doc = Nokogiri::HTML(description)

        # obter a imagem da noticia
        image = doc.css('a').map { |i| i['href'] } # Array of strings

        Content.create(title: item.title, link_image: image[0], description: "(sem descrição para apresentar)",
                       date: item.pubDate, views: 0, news_text: item.description, user_id: 1)

      end


      #   Content.create(title, link_image, description, date, views, news_text, user_id)
    end
    puts "============================ FIM FEEDS ==========================="

    # para evitar que dê erro que diz que a vista homepage/feeds nao existe
    render nothing: true
  end

  def index

  end

end