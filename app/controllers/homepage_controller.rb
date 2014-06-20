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
    # PARSE DE UM RSS FEED.APENAS PARA EFEITO DE TESTE, REMOVER MAIS TARDE!

    require 'rss'
    rss = RSS::Parser.parse('http://feeds.feedburner.com/PublicoRSS?format=xml', false)
    puts "============================ INICIO FEEDS ==========================="
    rss.items.each do |item|
      puts "#{item.pubDate} - #{item.title}"
    end
    puts "============================ FIM FEEDS ==========================="

    # para evitar que dê erro que diz que a vista homepage/feeds nao existe
    render nothing: true
  end

  # adicionar às routes (da mesma forma que o metodo de cima)
  # para podemos aceder-lhe no jquery
  def fetch_mail

    restaurants = ["Casa do Pessoal", "c@mpus.come", "Bar c@mpus", "Girassol",
                   "Teresa Gato", "Espaço Mais", "Snack-bar", "My Spot Bar"]
    ementas = [[], [], [], [], [], [], [], []]
    indexes = []

    require 'mail'
    Mail.defaults do
      retriever_method :imap, :address => "imap.gmail.com",
                       :port => 993,
                       :user_name => "grupo05pi@gmail.com",
                       :password => "badjoras",
                       :enable_ssl => true
    end

    puts "============================ INICIO EMAIL STUFF ==========================="

    menus = Menu.all
    menu1 = menus.where.not('restaurant' => "Cantina") #todos os menus que não sejam cantina
    # puts menu1.count
    menu2 = menus.where('date' => Date.today) #todos os menus do dia de hoje
    # puts menu2.count
    total = menu1 | menu2 #intersecção dos dois conjuntos
    # puts total.count

    # significa que ainda nao temos menus que nao sao da cantina (pois estes são obtidos noutro lado)
    # para a data de hoje (ou seja, ainda nao fizemos parse ao email do dia)
    if (total.count == 0)

      puts "nº de emails na conta: #{Mail.all.length}"

      # retorna o primeiro email nao lido
      mail = Mail.last

      # apenas a parte que interessa, o texto do email, e converte para um array
      mail_text = mail.parts[0].parts[0].body.to_s.split("\n")

      puts "\n*********************** 1 ***************************\n"
      puts "mail_text.length: #{mail_text.length}"

      # elimina as linhas que não têm conteudo
      mail_text.reject! { |t| t.length == 1 }

      puts "mail_text.length apos limpeza: #{mail_text.length}"
      puts "\n*********************** 2 ***************************\n"

      # ignora as ultimas linhas que é sobre meteorologia e nomes de badalhocas
      new_string = "Instituto Português do Mar e da Atmosfera".force_encoding("ASCII-8BIT")
      ind_temp = mail_text.index { |v| v.include?(new_string) }
      last_interesting_line_index = ind_temp-2

      puts "last_interesting_line_index: #{last_interesting_line_index}"
      puts "\n*********************** 3 ***************************\n"

      # indice a partir do qual começam as ementas
      pos = mail_text.index { |v| v.include?("Imagem intercalada 2") }
      pos=pos+1

      puts "posicao onde comecam as ementas: #{pos}"
      puts "\n*********************** 4 ***************************\n"

      puts "data do email #{mail.date.to_s}"

      # ficamos apenas com as linhas que têm ementas
      mail_text = mail_text[pos..-1]

      puts "\n*********************** 5 ***************************\n"

      # para cada restaurante, vamos guardar o indice onde comeca a ementa
      # no fim, juntamos o last_interesting_line_index
      restaurants.each do |rest|

        # para evitar problemas de incompatibilidade com cedilhas
        str_encoded = rest.force_encoding("ASCII-8BIT")
        ind = mail_text.index { |v| v.include?(str_encoded) }

        if ind.nil?
          ind = "esta merda é nula!"
        else
          ind = ind + pos + 2 #para ignorar as linhas do nome do restaurante
          indexes.push(ind)
        end
        puts "#{rest} -> #{ind}"
      end

      puts "\n*********************** 6 ***************************\n"

      # puts indexes

      # puts "\n*********************** 7 ***************************\n"

      indexes.push(last_interesting_line_index)

      # não queremos considerar o ultimo indice, aquele para ignorar as linhas da meteo
      for k in 0..indexes.length-2
        curr_restaurant = restaurants[k]

        # para evitar problemas de codificaçao com as cedilhas
        if k == 5
          curr_restaurant = "Espaco Mais"
        end

        curr_arr = ementas[k]

        # puts "---------------------------- #{curr_restaurant} ----------------------------"

        min = indexes[k]

        if k == indexes.length-2
          max = indexes[k+1] #ultima posição, não aplicar a regra de ignorar as tres ultimas linhas
        else
          max = indexes[k+1]-3 #para ignorar as linhas do proximo restaurante
        end

        puts "min:#{min} - max:#{max}"

        for x in min..max
          temp = mail_text[x-pos].force_encoding("UTF-8")

          curr_arr.push(temp)

          # cria uma entrada na base de dados
          Menu.create(meal: "almoço", dish: temp, restaurant: curr_restaurant, date: Date.today)
        end
      end

      # para efeitos de teste, remover mais tarde
      k=0
      ementas.each do |ementa|
        puts "--------- ementa: #{restaurants[k]} ---------"
        puts ementa
        k += 1
      end

      puts "\n*********************** 8 ***************************\n"

      i = pos
      mail_text.each do |t|
        lol = t.length
        isEmpty = t.eql? ""
        puts "#{lol}/#{i}: #{t}"
        i = i+1
      end

    else
      puts "JÁ TEMOS EMENTAS QUE NAO SAO DA CANTINA PARA O DIA DE HOJE"
    end

    puts "============================ FIM EMAIL STUFF ==========================="

    render nothing: true
  end

  def index

  end

end