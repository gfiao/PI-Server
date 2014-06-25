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
             "http://expresso.sapo.pt/static/rss/desporto_23414.xml"] #10

    rss = RSS::Parser.parse(feeds[3], false)
    puts "============================ INICIO FEEDS ==========================="

    puts rss.items
    # puts rss.title
    # puts rss.language
    # puts rss.lastBuildDate
    puts rss.image

    puts "\n********** intervalo **********\n"

    rss.items.each do |item|
      puts "#{item.pubDate} - #{item.title} (#{item.category})"
      # puts "#{item.enclosure}"
      puts "#{item.description}"
      # puts "#{item.category.text}"

      item.category.each do |cat|
        puts cat
      end

      # string_temp = item.category.split("<category>")
      # puts string_temp


      # string_temp = item.description.image
      # image = string_temp.split('/>')

      string_temp = item.description

      doc1 = Nokogiri::HTML(string_temp)
      image = doc1.css('img').map { |i| i['src'] } # Array of strings


      # doc1 = Nokogiri::HTML( string_temp )
      # category = doc.css('category').map{ |i| i['src'] } # Array of strings

      puts "\n\n\n #{image}\n\n\n"

      #   Content.create(title, link_image, description, date, views, news_text, user_id)

      # Content.create(title: item.title.to_s.force_encoding("UTF-8"), link_image: image[0], description: "Noticia de teste!!",
      #                date: item.pubDate, views: 0, news_text: item.description.to_s.force_encoding("UTF-8"), user_id: 1)


    end
    puts "============================ FIM FEEDS ==========================="

    # para evitar que dê erro que diz que a vista homepage/feeds nao existe
    render nothing: true
  end

  def index

  end

end