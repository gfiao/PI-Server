# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


first_names = ['Zé',
               'António',
               'Carlos',
               'Carlão',
               'Paulo',
               'Paulão',
               'Leonardo',
               'Guilherme',
               'Rafael',
               'Pedro',
               'José']

last_names = ['Fião',
              'Bizarra',
              'Bizarro',
              'Engatatão',
              'Lopes',
              'Costa',
              'Rato',
              'Sócrates']

genders = ['Masculino', 'Feminino']

courses = ['Informatica', 'Electrotécnica', 'Ambiente', 'Bioquimica', 'Materiais',
           'Civil', 'Gestão Industrial', 'Biomédica', 'Quimica', 'Fisica', 'Matemática', 'Mecânica']

# USERS name:string birth_date:date gender:string course:string about_me:text
#A data de nascimento terá de ser mudada posteriormente, para cada pessoa ter uma data realista
#O about_me tambem poderá ser mudado
puts 'Adding 50 random Users'

1.upto(50) do |i|
  if i == 1
    User.create(
        name: 'Administrador',
        birth_date: Date.today,
        gender: 'Masculino',
        course: 'Informática',
        about_me: 'Conta de administrador do sistema!',
        email: 'admin@campus.fct.unl.pt',
        password: 'adminadmin',
        password_confirmation: 'adminadmin',
        avatar_url: 'http://noticias.rumonet.pt/wp-content/uploads/2013/02/logo_FCTUNL.jpg'
    )
  elsif i == 25
    puts 'Done 25, almost there'
  elsif i == 50
    User.create(
        name: 'Renato Alexandre',
        birth_date: Date.today,
        gender: 'Feminino',
        course: 'Informática',
        about_me: 'Curto bué de gajas de Erasmus :D',
        email: 'renato.alexandre@campus.fct.unl.pt',
        password: 'qweqweqwe',
        password_confirmation: 'qweqweqwe',
        avatar_url: 'http://img4.wikia.nocookie.net/__cb20121207145720/aleixo/images/7/75/Renato_disco.jpg')
  else
    r=Random.rand(10)
    r2=Random.rand(12)
    User.create(
        name: first_names[(r+i)%first_names.length] + ' ' + last_names[(r2+i)%last_names.length],
        birth_date: Date.today(),
        gender: genders[(r+i)%genders.length],
        course: courses[(r2+i)%courses.length],
        about_me: 'Hehe sou a pessoa número ' + i.to_s + ' e sou muita fixe, hehe',
        email: first_names[(r+i)%first_names.length]+'.'+last_names[(r2+i)%last_names.length]+'@campus.fct.unl.pt',
        password: 'qweqweqwe',
        password_confirmation: 'qweqweqwe',
        avatar_url: 'http://noticias.rumonet.pt/wp-content/uploads/2013/02/logo_FCTUNL.jpg'
    )
  end
end


#Content title:string link_image:string description:text date:date news_text:text
puts 'Adding News Content'
Content.create(title: 'Leslie Lamport vem à FCT!', link_image: 'LeslieLamport_960.jpg',
               description: 'Leslie Lamport vem dar uma palestra à grandiosa FCT', date: Date.today(), views: 3,
               news_text: 'Hehe placeholder!', user_id: 1)
Content.create(title: 'Barbara Liskov vem à FCT!', link_image: 'top-prize.jpg',
               description: 'Barbara Liskov, vencedora do Turing Award, vem dar uma palestra à grandiosa FCT',
               date: Date.today(), views: 10, news_text: 'Inaugural Lecture "Programming the Turing Machine", by Prof. Barbara Liskov, Massachusetts Institute of Technology
October, 3th, 2012 - 14h30m (Main Auditorium FCT/UNL)

The distinguished lecture series of the Computer Science Department (DI) at FCT-UNL brings to the department some of the most influential researchers and practitioners in the field of computer science. This distinguished lecture series aims at giving students and researchers
an opportunity to know more about some of the most groundbreaking work in computer science and the people who led this work, and will hopefully become a source of inspiration for the future career of the students in the department. The series will host only a very small
number of talks every year, so that it can focus on outstanding computer scientists and engineers who are leaders in their fields of knowledge.

"Programming the Turing Machine"

Turing provided the basis for modern computer science. However there is a huge gap between a Turing machine and the kinds of applications we use today. This gap is bridged by software, and designing and implementing large programs is a difficult task. The main way we have of keeping the complexity of software under control is to make use of abstraction and modularity.

This talk will discuss how abstraction and modularity are used in the design of large programs, and how these concepts are supported in modern programming languages. It will also discuss what support is needed going forward.

Professor Barbara Liskov short bio:

Barbara Liskov is an Institute Professor at MIT and also Associate Provost for Faculty Equity. She is a member of the National Academy of Engineering and the National Academy of Sciences, a fellow of the American Academy of Arts and Sciences, and a fellow of the ACM. She received the ACM Turing Award in 2009, the ACM SIGPLAN Programming Language Achievement Award in 2008, the IEEE Von Neumann medal in 2004, a lifetime achievement award from the Society of Women Engineers in 1996, and in 2003 was named one of the 50 most important women in science by Discover Magazine. Her research interests include
distributed systems, replication algorithms to provide fault-tolerance, programming methodology, and programming languages. Her current research projects include
Byzantine-fault-tolerant storage systems and online storage systems that provide confidentiality and integrity for the stored information.', user_id: 10)
# Content.create(title: 'Sócia da FCT ganhou prémio!', link_image: 'destaque_4.jpg',
#                description: 'Sócia da FCT ganhou 1 Milhão de Euros pela sua investigação.',
#                date: Date.today(), views: 30, news_text: 'Hehe placeholder!', user_id: 24)
# Content.create(title: 'Noticia de ultima hora! FCT a arder!', link_image: 'imagem_iycr2014.jpg',
#                description: 'FCT a arder! Edificios a ruir! Esta noticia esta aqui para termos 4 noticias!',
#                date: Date.today(), views: 55, news_text: 'Hehe placeholder!', user_id: 30)
Content.create(title: 'Video de apresentação do MIEI',
               description: 'Video de apresentação do MIEI visa dar a conhecer o curso.',
               date: Date.today(), views: 15, news_text: 'O Departamento de Informática da FCT-UNL criou um video de
                apresentação do Mestrado Integrado em Engenharia Informática', user_id: 1)
Content.create(title: 'A FCT fez 36 anos!',
               description: 'A FCT fez no ano passado 36 anos.',
               date: Date.today(), views: 15, news_text: 'A FCT fez no ano passado 36 anos.
                Acede já ao canal de Youtube da faculdade para veres os melhores momentos do 36º ano da FCT', user_id: 1)
Content.create(title: 'A FCT fez 35 anos!',
               description: 'Os melhores momentos do 35º ano da FCT.',
               date: Date.today(), views: 15, news_text: 'A FCT fez à dois anos 35 anos.
                Acede já ao canal de Youtube da faculdade para veres os melhores momentos do 35º ano da FCT', user_id: 1)
Content.create(title: 'Inovação na FCT!',
               description: 'Apresentação dos Centros de Investigação da FCT.',
               date: Date.today(), views: 15, news_text: 'Apresentação dos Centros de Investigação da Faculdade de Ciências e Tecnologia da Universidade Nova de Lisboa.
               Acede já ao canal de Youtube da faculdade para veres o que melhor se faz de investigação na FCT', user_id: 1)
Content.create(title: 'Apresentação da FCT!',
               description: 'Video de apresentação da FCT.',
               date: Date.today(), views: 15, news_text: 'Apresentação da Faculdade de Ciências e Tecnologia da Universidade Nova de Lisboa.
               Acede já ao canal de Youtube da faculdade para veres o que melhor se faz de investigação na FCT', user_id: 1)
Content.create(title: 'Biblioteca: Exposição Déjeuner Sur L\'Herbe', link_image: 'herbe.jpg', description: 'Déjeuner sur L´herbe, 08 Maio a 31 Julho,
Jardim em frente à Biblioteca da FCT/UNL, Inauguração: 08 de Maio às 17:00h', date: Date.today(), views: 22, news_text: 'Jorge Pé-Curto, Paulo Neves, Rui Matos, Vitor Ribeiro e Volker Schnüttgen voltam agora ao Campus da FCT/UNL, acompanhados por Matthias Contzen, fluem num processo criativo e original.
De um desafio tão grande, quanto inovador, resultados inesperados eram antecipados...
Como num picnic, os seis escultores “espalharam” e “plantaram” esculturas no relvado frontal da Biblioteca, permitindo a fruição de propostas imaginativas e “saborosas”. As esculturas convivem. Os diferentes materiais comunicam e surpreendem...
O espaço exterior recriado, gloza Manet, no delicioso e brilhante “Déjeuner sur l`Herbe”.
As esculturas repousam (no espaço) e despertam (espaços)...', user_id: 1)

Content.create(title: 'Biblioteca: Exposição "A DEUS"', link_image: 'MonicaCid_ConviteEletronico.jpg',
               description: 'Exposição "A DEUS", Desenho / Instalação de Mónica CID, 14 Maio a 31 de Julho, Sala de Exposições da Biblioteca FCT/UNL, Inauguração: 14 Maio às 17:00h',
               date: Date.today(), views: 12, news_text: 'Há doze anos que Mónica Cid (Lisboa, 1973) cria diários gráficos. Doze anos a observar o quotidiano, as pessoas que por ela passam, os seus movimentos, os seus gestos. Uma vivência pessoal passada a desenho e transformada em algo de belo e mágico. Nesta exposição, Cid converte os seus livros em esculturas: figuras que saem das folhas, que dialogam entre si, que interpelam os desenhos que continuam planos.
Se fosse um livro, esta exposição começaria assim: “Uma linha, cansada de ser linha, abandona o caderno onde estava presa e transforma-se na silhueta de um homem em fuga. O caderno agora vazio transforma-se numa parede branca, à espera de ser riscada.”
Tudo se inicia num bloco de desenhos. Um bloco em branco que sai à rua, que se deita na mesa de um café e que aguarda que a mão de quem o segura comece os seus movimentos. Uma folha que deseja a caneta, que anseia pelo momento em que aquela lhe toca pela primeira vez e que a linha nasce. Quando a acção se inicia, os movimentos são tão rápidos que o caderno nem consegue perceber o que está a ser desenhado. A linha transforma-se numa senhora sentada, num rosto de um homem, numa mãe que leva uma criança pela mão... Por vezes, são frases, notas ou ideias que surgem.
Os gestos dos corpos das pessoas que passam pelo caderno são transpostos para as folhas, como se a mão que desenha tornasse seus esses mesmos movimentos e os transformasse em linhas. A fluidez da linha é adversa do pensamento. Estas não são linhas pensantes, mas linhas de acção, linhas em movimento, linhas que seguem olhos. Os desenhos organizam-se de forma despreocupada na folha. Não há neste acto de desenhar um cuidado com a composição dos elementos na folha. A folha enche-se instintivamente num processo de descoberta.
O caderno, cansado de ser riscado, acaba o seu dia no atelier e é aí que o real do quotidiano se transforma num mundo inventado. É aí que a linha que desenha se transfigura em linha que esculpe. Os desenhos saem das folhas à procura de uma nova vida. Antes desenhos com linhas agora esculturas de linhas. A escultura reinventa o desenho, reimagina-o, transporta-o de volta a um mundo físico, mas desta vez não para a trivialidade do dia-a-dia mas para um lugar fantasiado e encantador. Um mundo que nos faz sorrir, que nos leva para um imaginário mágico dos livros de crianças, dos livros que já foram escritos e que a nossa memória evoca, mas também dos livros que ainda não foram escritos e que a imaginação de cada espectador compõe.
Desenho feito escultura e escultura feita de desenho. Os dois gestuais concentrados numa exploração da linha, da figura e do movimento. ', user_id: 1)


#Video link:string category_id:integer
puts 'Adding Videos'
# Video.create(link: 'https://www.youtube.com/embed/iaItmiZTHP8') #Quim Barreiros
# Video.create(link: 'https://www.youtube.com/embed/Ci6lMQNLKZU') #Mortal Kombat X
Video.create(link: 'https://www.youtube.com/embed/LbmvzjhaPEg', content_id: 3) #Apresentaçao MIEI
Video.create(link: 'https://www.youtube.com/embed/FVgZjyevTuI', content_id: 4) #36º Aniversario FCT
Video.create(link: 'https://www.youtube.com/embed/bHwzUHSNVxg', content_id: 5) #35º Aniversario FCT
Video.create(link: 'https://www.youtube.com/embed/mKXIXPiVk3U', content_id: 6) #FCT-UNL Inovação
Video.create(link: 'https://www.youtube.com/embed/YXCNFeeH1Ow', content_id: 7) # FCT-UNL (Apresentaçao 2011)
# Video.create(link: 'https://www.youtube.com/embed/9yNtJsFxDQI') #Cena de AA

#BookmarkedContent user_id:integer content_id:integer
puts 'Adding Bookmarks'
BookmarkedContent.create(user_id: 3, content_id: 1)
BookmarkedContent.create(user_id: 13, content_id: 2)
BookmarkedContent.create(user_id: 23, content_id: 3)
BookmarkedContent.create(user_id: 35, content_id: 1)
BookmarkedContent.create(user_id: 21, content_id: 2)
BookmarkedContent.create(user_id: 9, content_id: 3)
BookmarkedContent.create(user_id: 7, content_id: 1)
BookmarkedContent.create(user_id: 31, content_id: 2)
BookmarkedContent.create(user_id: 29, content_id: 3)


#Tag tag:string
puts 'Adding new Tags'
Tag.create(tag: 'Informática')
Tag.create(tag: 'Bioquimica')
Tag.create(tag: 'Ambiente')
Tag.create(tag: 'Geral')
Tag.create(tag: 'Electrotécnica')
Tag.create(tag: 'Matemática')
Tag.create(tag: 'Física')

#TagContent content_id:integer tag_id:integer
puts 'Adding Tag to Contents'
TagContent.create(content_id: 1, tag_id: 1)
TagContent.create(content_id: 2, tag_id: 1)
TagContent.create(content_id: 3, tag_id: 2)

#Classrooms building:string classroom:string
puts 'Adding Classrooms'
Classroom.create(building: 'Ed.7', classroom: '2.3')
Classroom.create(building: 'Ed.7', classroom: '1D')
Classroom.create(building: 'Ed.7', classroom: '1C')
Classroom.create(building: 'Ed.7', classroom: '2B')
Classroom.create(building: 'Ed.7', classroom: '1.13')
Classroom.create(building: 'Ed.2', classroom: '119')
Classroom.create(building: 'Ed.2', classroom: '121')
Classroom.create(building: 'Ed.2', classroom: '115')
Classroom.create(building: 'Ed.2', classroom: '120')

#FreeClassroom user_id:integer classroom_id:integer from_time:datetime likes:integer, to_time:datetime
puts 'Adding Free Classrooms'
FreeClassroom.create(user_id: 1, classroom_id: 1, from_time: DateTime.now, to_time: DateTime.now + 2.hours)
FreeClassroom.create(user_id: 10, classroom_id: 4, from_time: DateTime.now, to_time: DateTime.now+ 3.hours)
FreeClassroom.create(user_id: 10, classroom_id: 3, from_time: DateTime.now, to_time: DateTime.now)

#Game name:string
puts 'Adding Games'
Game.create(name: '2048')
Game.create(name: '4-em-linha')
Game.create(name: 'Batalha Naval')

#Score user_id:integer game_id:integer score:integer
puts 'Adding Scores'
Score.create(user_id: 5, game_id: 1, score: 30000)
#Score.create(user_id: 5, game_id: 3, score: 2000)
Score.create(user_id: 1, game_id: 1, score: 20450)
Score.create(user_id: 8, game_id: 1, score: 13056)
Score.create(user_id: 28, game_id: 1, score: 7624)
Score.create(user_id: 31, game_id: 1, score: 1464)
Score.create(user_id: 13, game_id: 1, score: 506)
#Score.create(user_id: 1, game_id: 2, score: 140)
Score.create(user_id: 6, game_id: 1, score: 43218)

#FooterNews category:string news:string date:date
puts 'Adding Footer News'
# FooterNews.create(category: 'País', news: 'Pedro Passos Coelho demite-se, após ter sido publicado que este é alemão.', date: Date.today())
# FooterNews.create(category: 'Desporto', news: 'Benfica é campeão!', date: Date.today())
FooterNews.create(category: 'Faculdade', news: 'Após uma longa reunião com representantes dos alunos, foi anunciado uma redução das propinas.', date: Date.today())
FooterNews.create(category: 'Faculdade', news: 'O limite para as candidaturas Erasmus acaba daqui a uma semana.', date: Date.today())
FooterNews.create(category: 'Faculdade', news: 'Casas de banho do Ed.VII fechadas devido às más condições das mesmas.', date: Date.today())
FooterNews.create(category: 'Faculdade', news: 'A Época Especial irá decorrer entre 21 e 26 de Julho. As inscrições já abriram.', date: Date.today())
FooterNews.create(category: 'Faculdade', news: 'A data limite para a entrega de dissertações e teses é 22 de Setembro.', date: Date.today())
FooterNews.create(category: 'País', news: 'Isaltino Morais saiu da prisão e ficou em liberdade condicional, mas não pode sair do país.', date: Date.today())
FooterNews.create(category: 'País', news: 'Berardo exige ao Governo da Madeira indemnizações de um milhão de euros.', date: Date.today())

#cena temporaria para o indice inicial do que esta na TV (começa a zero para indicar que a TV está desligada)
CurrentVideo.create(index: 0)

#Transports carreira:integer origin:integer destination:integer
#  carreira = 0 => MTS
puts 'Adding Transports'
Transport.create(carreira: 0, origin: 'Universidade', destination: 'Cacilhas')
Transport.create(carreira: 126, origin: 'Cacilhas', destination: 'Marisol')
Transport.create(carreira: 194, origin: 'Costa da Caparica', destination: 'Pragal(Est)')

#Hours hour:integer minute:integer
puts 'Adding Hours'
10.upto(17) do |i|
  j = 0
  k = 2
  while k < 60
    Hour.create(hour: i, minute: j)
    Hour.create(hour: i, minute: k)
    j += 5
    k += 5
  end
end

#TransportHours transport_id:integer hour_id:integer
puts 'Adding TransportHours'
# TransportHour.create(transport_id: Transport.find_by(carreira: 0).id, hour_id: Hour.find_by(hour: 10, minute: 12).id)
# TransportHour.create(transport_id: Transport.find_by(carreira: 0).id, hour_id: Hour.find_by(hour: 10, minute: 17).id)
# TransportHour.create(transport_id: Transport.find_by(carreira: 0).id, hour_id: Hour.find_by(hour: 10, minute: 22).id)
TransportHour.create(transport_id: Transport.find_by(carreira: 0).id, hour_id: Hour.find_by(hour: 11, minute: 42).id)
TransportHour.create(transport_id: Transport.find_by(carreira: 0).id, hour_id: Hour.find_by(hour: 10, minute: 47).id)
TransportHour.create(transport_id: Transport.find_by(carreira: 0).id, hour_id: Hour.find_by(hour: 10, minute: 52).id)
TransportHour.create(transport_id: Transport.find_by(carreira: 0).id, hour_id: Hour.find_by(hour: 10, minute: 57).id)
# TransportHour.create(transport_id: Transport.find_by(carreira: 0).id, hour_id: Hour.find_by(hour: 22, minute: 47).id)
# TransportHour.create(transport_id: Transport.find_by(carreira: 0).id, hour_id: Hour.find_by(hour: 22, minute: 37).id)
TransportHour.create(transport_id: Transport.find_by(carreira: 126).id, hour_id: Hour.find_by(hour: 11, minute: 45).id)
TransportHour.create(transport_id: Transport.find_by(carreira: 126).id, hour_id: Hour.find_by(hour: 11, minute: 40).id)
# TransportHour.create(transport_id: Transport.find_by(carreira: 126).id, hour_id: Hour.find_by(hour: 17, minute: 55).id)
TransportHour.create(transport_id: Transport.find_by(carreira: 194).id, hour_id: Hour.find_by(hour: 11, minute: 55).id)
# TransportHour.create(transport_id: Transport.find_by(carreira: 194).id, hour_id: Hour.find_by(hour: 18, minute: 0).id)
# TransportHour.create(transport_id: Transport.find_by(carreira: 194).id, hour_id: Hour.find_by(hour: 22, minute: 40).id)
# TransportHour.create(transport_id: Transport.find_by(carreira: 126).id, hour_id: Hour.find_by(hour: 22, minute: 45).id)


#UserContent user_id:integer content_id:integer
puts 'Associating content to users'
UserContent.create(user_id: 1, content_id: 1)
UserContent.create(user_id: 10, content_id: 2)
UserContent.create(user_id: 24, content_id: 3)