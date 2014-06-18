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

    # para evitar que dê erro que diz que a vista homepage/feeds nao existe
    render nothing: true
  end

  # adicionar às routes (da mesma forma que o metodo de cima)
  # para podemos aceder-lhe no jquery
  def fetch_mail

    require 'mail'
    Mail.defaults do
      retriever_method :imap, :address => "imap.gmail.com",
                       :port => 993,
                       :user_name => "grupo05pi@gmail.com",
                       :password => "badjoras",
                       :enable_ssl => true
    end

    puts "============================ INICIO EMAIL STUFF ==========================="

    emails = Mail.all
    puts emails.length
    # puts "\n*********************** 0 ***************************\n"
    # emails = Mail.find(:what => :first, :count => 2, :order => :desc)

    mail = Mail.first
    # mails.each do |mail|

    # puts mail

    puts "\n*********************** 3 ***************************\n"
    puts mail.multipart? #=> true
    puts "\n*********************** 4 ***************************\n"
    puts mail.parts.length #=> 2
    # puts "\n*********************** 5 ***************************\n"
    # puts mail.body.preamble #=> "Text before the first part"
    # puts "\n*********************** 6 ***************************\n"
    # puts mail.body.epilogue #=> "Text after the last part"
    puts "\n*********************** 7 ***************************\n"
    mail.parts.map { |p| puts p.content_type } #=> ['text/plain', 'application/pdf']
    puts "\n*********************** 8 ***************************\n"
    mail.parts.map { |p| puts p.class } #=> [Mail::Message, Mail::Message]
    puts "\n*********************** 9 ***************************\n"
    puts mail.parts[0].content_type_parameters #=> {'charset' => 'ISO-8859-1'}
    puts "\n*********************** 10 ***************************\n"
    puts mail.parts[1].decoded #=> {'name' => 'my.pdf'}
    puts "\n*********************** 11 ***************************\n"
    puts mail.parts[2].content_type_parameters #=> {'name' => 'my.pdf'}
    puts "\n*********************** 12 ***************************\n"
    puts mail.parts[3].content_type_parameters #=> {'name' => 'my.pdf'}

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