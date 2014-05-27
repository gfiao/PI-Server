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

courses = ['Mestrado Integrado em Engenharia Informatica',
           'Mestrado Integrado em Engenharia Electrotecnica',
           'Mestrado Integrado em Engenharia do Ambiente',
           'Licenciatura em Bioquimica',
           'Licenciatura em Engenharia dos Materiais']

# USERS name:string birth_date:date gender:string course:string about_me:text
#A data de nascimento terá de ser mudada posteriormente, para cada pessoa ter uma data realista
#O about_me tambem poderá ser mudado
puts 'Adding 50 random Users'
1.upto(50) do |i|
  if i == 25
    puts 'Done 25, almost there'
  end
  r=Random.rand(10);
  r2=Random.rand(8);
  User.create(
      name: first_names[(r+i)%first_names.length] + ' ' + last_names[(r2+i)%last_names.length],
      birth_date: Date.today(),
      gender: genders[(r+i)%genders.length],
      course: courses[(r2+i)%courses.length],
      about_me: 'Hehe sou a pessoa número ' + i.to_s + ' e sou muita fixe, hehe',
      email: first_names[(r+i)%first_names.length]+'#{i}'+last_names[(r2+i)%last_names.length]+'@gMaile.com',
      password: 'qweqweqwe',
      password_confirmation: 'qweqweqwe'
  )
end

#Content title:string link_image:string description:text date:date
puts 'Adding News Content'
Content.create(title: 'Leslie Lamport vem à FCT!', link_image: 'LeslieLamport_960.jpg',
               description: 'Leslie Lamport vem dar uma palestra à grandiosa FCT', date: Date.today(), views: 3)
Content.create(title: 'Barbara Liskov vem à FCT!', link_image: 'top-prize.jpg',
               description: 'Barbara Liskov, vencedora do Turing Award, vem dar uma palestra à grandiosa FCT',
               date: Date.today(), views: 10)
Content.create(title: 'Sócia da FCT ganhou prémio!', link_image: 'destaque_4.jpg',
               description: 'Sócia da FCT ganhou 1 Milhão de Euros pela sua investigação.',
               date: Date.today(), views: 30)
Content.create(title: 'Noticia de ultima hora! FCT a arder!', link_image: 'imagem_iycr2014.jpg',
               description: 'FCT a arder! Edificios a ruir! Esta noticia esta aqui para termos 4 noticias!',
               date: Date.today(), views: 55)

#UserContent user_id:integer content_id:integer
puts 'Associating content to users'
UserContent.create(user_id: 1, content_id: 1)
UserContent.create(user_id: 10, content_id: 2)
UserContent.create(user_id: 24, content_id: 3)

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
Classroom.create(building: 'Ed.7', classroom: '1.13')
Classroom.create(building: 'Ed.2', classroom: '119')
Classroom.create(building: 'Ed.2', classroom: '121')

#FreeClassroom user_id:integer classroom_id:integer time:datetime
puts 'Adding Free Classrooms'
FreeClassroom.create(user_id: 1, classroom_id: 1, time: DateTime.now)
FreeClassroom.create(user_id: 10, classroom_id: 4, time: DateTime.now)

#Game name:string
puts 'Adding Games'
Game.create(name: '2048')
Game.create(name: '4-em-linha')
Game.create(name: 'Batalha Naval')

#Score user_id:integer game_id:integer score:integer
puts 'Adding Scores'
Score.create(user_id: 5, game_id: 1, score: 30000)
Score.create(user_id: 5, game_id: 3, score: 2000)
Score.create(user_id: 1, game_id: 1, score: 20450)
Score.create(user_id: 8, game_id: 1, score: 13056)
Score.create(user_id: 28, game_id: 1, score: 7624)
Score.create(user_id: 31, game_id: 1, score: 1464)
Score.create(user_id: 13, game_id: 1, score: 506)
Score.create(user_id: 1, game_id: 2, score: 140)
Score.create(user_id: 6, game_id: 1, score: 43218)

#Video link:string
puts 'Adding Videos'
Video.create(link: 'https://www.youtube.com/embed/iaItmiZTHP8')
Video.create(link: 'https://www.youtube.com/embed/FVgZjyevTuI')
Video.create(link: 'https://www.youtube.com/embed/bHwzUHSNVxg')
Video.create(link: 'https://www.youtube.com/embed/mKXIXPiVk3U')
Video.create(link: 'https://www.youtube.com/embed/YXCNFeeH1Ow')

#ContentVideo content_id:integer video_id:integer
puts 'Associating videos to content'
ContentVideo.create(content_id: 1, video_id: 1)

