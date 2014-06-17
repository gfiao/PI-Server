class HomepageController < ApplicationController
  before_filter :update_video

  def update_video

    #estamos a aceder a partir da TV, actualizar o indice caso seja diferente do actual
    if !(params[:currIndex].nil?)
      # puts "fobiywvbefkf jobcwf qfb qefqbef qefb fq fqfwfqfbqi fjqhfbq fuiuhjnd qw   djkmsd bn "
      @video_id_table = CurrentVideo.first
      @currentVideo = params[:currIndex]

      puts "=================================================="
      puts @currentVideo

      if !(@video_id_table.index == @currentVideo)
        @video_id_table.index = @currentVideo
        @video_id_table.save
        puts @video_id_table.index
      end
    else
    end
  end

  def feeds
    # PARSE DE UM RSS FEED.APENAS PARA EFEITO DE TESTE, REMOVER MAIS TARDE!

    require 'rss'
    rss = RSS::Parser.parse('http://feeds.feedburner.com/PublicoRSS?format=xml', false)
    puts "============================ INICIO FEEDS ==========================="
    rss.items.each do |item|
      puts "#{item.pubDate} - #{item.title}"
    end
    puts "============================ FIM FEEDS ==========================="

    render nothing: true
  end

  def index

  end

end