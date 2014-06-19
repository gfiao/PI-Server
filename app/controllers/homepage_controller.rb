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
    ementas = [[],[],[],[],[],[],[],[]]
    indexes = []

    # ind = 0
    # first_arr = [""]

    # passar esta inicialização para o outro FOR mais abaixo, se possivel
    # restaurants.each do
    #   ementas[ind] = Array.new(10, first_arr)
    #   ind = ind + 1
    # end

    # puts ementas[0][].nil?

    require 'mail'
    Mail.defaults do
      retriever_method :imap, :address => "imap.gmail.com",
                       :port => 993,
                       :user_name => "grupo05pi@gmail.com",
                       :password => "badjoras",
                       :enable_ssl => true
    end

    puts "============================ INICIO EMAIL STUFF ==========================="

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

    # ignora as ultimas linhas que é sobre meteorologia
    last_interesting_line_index = mail_text.length - 3

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

    puts "\n*********************** 7 ***************************\n"

    indexes.push(last_interesting_line_index)

    # não queremos considerar o ultimo indice, aquele para ignorar as linhas da meteo
    for k in 0..indexes.length-2

      curr_arr = ementas[k]

      min = indexes[k]
      max = indexes[k+1]-3 #para ignorar as linhas do proximo restaurante
      # puts "min:#{min} - max:#{max}"

      for x in min..max
        temp = mail_text[x-pos]
        # puts "#{x}: #{temp}"

        curr_arr.push(temp)
        # puts "#{x}: #{temp}"
        # i = i+1

        # str_ementa = str_ementa + temp
        #
        # if x==max
        #   ementas[k] = str_ementa
        # end

      end
      # puts "Ementa completa: #{str_ementa}."
    end

    # para efeitos de teste, remover mais tarde
    k=0
    ementas.each do |ementa|
      puts "--------- ementa: #{restaurants[k]} ---------"
      puts ementa
      k += 1
    end

    # puts "\n*********************** 8 ***************************\n"
    #
    # i = pos
    # mail_text.each do |t|
    #   lol = t.length
    #   isEmpty = t.eql? ""
    #   puts "#{lol}/#{i}: #{t}"
    #   i = i+1
    # end

    "============================ COMENTARIOS, eliminar mais tarde ==========================="

    # mail = Mail.first
    # mail = Mail.find(:what => :first, :count => 1, :order => :asc)

    # puts "\n*********************** 0 ***************************\n"
    # emails = Mail.find(:what => :first, :count => 2, :order => :desc)

    # mails.each do |mail|

    # puts mail

    # puts "\n*********************** 3 ***************************\n"
    # puts mail.multipart? #=> true
    # puts "\n*********************** 4 ***************************\n"
    # puts mail.parts.length #=> 2
    # puts "\n*********************** 5 ***************************\n"
    # # puts mail.body.preamble #=> "Text before the first part"
    # puts mail.content_type_parameters
    # # puts "\n*********************** 6 ***************************\n"
    # # puts mail.body.epilogue #=> "Text after the last part"
    # puts "\n*********************** 7 ***************************\n"
    # mail.parts.map { |p| puts p.content_type } #=> ['text/plain', 'application/pdf']
    # puts "\n*********************** 8 ***************************\n"
    # mail.parts.map { |p| puts p.class } #=> [Mail::Message, Mail::Message]
    # puts "\n*********************** 9 ***************************\n"
    # mail.parts[0].parts.map { |p| puts p.content_type } #=> {'charset' => 'ISO-8859-1'}
    # puts "\n*********************** 10 ***************************\n"
    # mail.parts[0].parts.map { |p| puts p.class }
    # puts "\n*********************** 11 ***************************\n"
    # puts mail.parts[0].parts[0].content_type_parameters #=> {'name' => 'my.pdf'}
    # puts "\n*********************** 12 ***************************\n"
    # puts mail.parts[0].parts[1].content_type_parameters #=> {'name' => 'my.pdf'}
    # # puts "\n*********************** 13 ***************************\n"
    # # puts mail.parts[0].parts[0].body.to_s #=> {'name' => 'my.pdf'}
    # puts "\n*********************** 13 ***************************\n"
    # # puts mail.parts[0].parts[1].body.to_s #=> {'name' => 'my.pdf'}


    # puts mail.parts[1].content_type_parameters #=> {'name' => 'my.pdf'}
    # puts "\n*********************** 11 ***************************\n"
    # puts mail.parts[2].content_type_parameters #=> {'name' => 'my.pdf'}
    # puts "\n*********************** 12 ***************************\n"
    # puts mail.parts[3].content_type_parameters #=> {'name' => 'my.pdf'}

    # puts mail.envelope_from   #=> 'mikel@test.lindsaar.net'
    #
    # puts "\n*********************** 3 ***************************\n"
    # puts mail.to              #=> 'bob@test.lindsaar.net' FUNCIONA
    # puts "\n*********************** 4 ***************************\n"
    # puts mail.cc              #=> 'sam@test.lindsaar.net' NAO TESTADO
    # puts "\n*********************** 5 ***************************\n"
    # puts mail.subject         #=> "This is the subject" FUNCIONA
    # puts "\n*********************** 6 ***************************\n"
    # puts mail.date.to_s       #=> '21 Nov 1997 09:55:06 -0600' FUNCIONA
    # puts "\n*********************** 7 ***************************\n"
    # puts mail.message_id      #=> '<4D6AA7EB.6490534@xxx.xxx>'
    # puts "\n*********************** 8 ***************************\n"
    # puts mail.body.decoded    #=> 'This is the body of the email...  NÃO ESTÁ BEM..
    # puts "\n*********************** 9 ***************************\n"
    # puts mail.multipart?      #=> true     FUNCIONA
    # puts "\n*********************** 10 ***************************\n"
    # puts mail.body
    # puts "\n*********************** 11 ***************************\n"
    # puts mail.body.to_s
    # puts "\n*********************** 12 ***************************\n"
    #
    #
    # puts "\n*********************** 1 ***************************\n"
    # # puts mail.from.address  #=> ['mikel@test.lindsaar.net', 'ada@test.lindsaar.net'] NAO FUNCIONA ESTE METODO
    # puts "\n*********************** 2 ***************************\n"
    # puts mail.sender  #=> 'mikel@test.lindsaar.net'  NAO FUNCIONA ESTE METODO

    # end

    puts "============================ FIM EMAIL STUFF ==========================="

    render nothing: true
  end

  def index

  end

end