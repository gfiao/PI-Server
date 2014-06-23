class TvController < ApplicationController
  before_filter :fetch_mail
  http_basic_authenticate_with :name => "admin", :password => "badjoras"

  def show
    render :layout => false
  end

  # este metodo está dividido em duas partes:
  # -a primeira parte obtem a ementa da cantina a partir do email;
  # -a segunda parte faz parse ao email do FCT hoje
  def fetch_mail

    puts "\n******************************** inicio CANTINA 1/2 ********************************\n"

    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'

    i = 0
    puts "=============== DATA DE HOJE ==============="
    puts Date.today
    puts "=============== TAMANHO DA TABELA MENU ==============="
    puts Menu.all.size

    meals = Menu.all.where('date' => Date.today, 'restaurant' => "Cantina")

    # ainda nao há ementas de hoje da cantina, vamos obtê-las!
    if meals.size == 0
      success = false
    else
      success = true
    end

    # no maximo tenta obter a pagina 10 vezes, isto porque a pagina pode vir nula
    while (!success && (i < 10))

      file = open("http://sas.unl.pt/cantina")
      page = Nokogiri::HTML(file)

      puts "=============== A PAGINA É NULA?? ==============="

      ementaFCT = page.css('div.cantina')
      ementaFCT = ementaFCT[0]
      puts page.nil?
      puts ementaFCT.nil?

      if !(ementaFCT.nil?)
        puts "=============== a pagina nao é nula, ainda bem que entrou aqui ==============="
        pratosAlmoco = ementaFCT.css('.lunch').css('.dish')
        pratosJantar = ementaFCT.css('.dinner').css('.dish')

        pratosAlmoco.each do |prato|
          prato.text.split(";").each do |temp|
            Menu.create(meal: "almoço", dish: temp, date: Date.today(), restaurant: "Cantina")
          end
        end
        pratosJantar.each do |prato|
          prato.text.split(";").each do |temp|
            Menu.create(meal: "jantar", dish: temp, date: Date.today(), restaurant: "Cantina")
          end
        end

        success = true
      end

      file.close
      i = i+1
    end

    puts "=============== NUMERO DE ITERAÇOES ==============="
    puts i
    puts "=============== TAMANHO DO MENU NO FIM DA CENA ==============="
    puts Menu.all.count
    puts "=============== FIM DO TESTE ==============="


    puts "\n******************************** fim CANTINA 1/2 ********************************\n"

    puts "\n******************************** inicio FCT HOJE 2/2 ********************************\n"


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

    menus = Menu.all
    menu1 = menus.where.not('restaurant' => "Cantina") #todos os menus que não sejam cantina
    puts menu1.count
    menu2 = menus.where('date' => Date.today) #todos os menus do dia de hoje
    puts menu2.count
    total = menu1 & menu2 #intersecção dos dois conjuntos
    puts total.count

    # significa que ainda nao temos menus que nao sao da cantina (pois estes são obtidos noutro lado)
    # para a data de hoje (ou seja, ainda nao fizemos parse ao email do dia)
    if (total.count == 0)

      puts "nº de emails na conta: #{Mail.all.length}"

      # retorna o primeiro email nao lido
      mail = Mail.last

      # apenas a parte que interessa, o texto do email, e converte para um array
      mail_text = mail.parts[0].parts[0].body.to_s.split("\n")

      # puts mail_text

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
      pos = mail_text.index { |v| v.include?("Casa do Pessoal") }
      # pos=pos+1

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


    puts "\n******************************** fim FCT HOJE 2/2 ********************************\n"
  end

end
