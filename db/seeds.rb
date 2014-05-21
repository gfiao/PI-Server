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
      password: '123123123',
      password_confirmation: '123123123'
  )
end

#Content title:string link_image:string description:text date:date
puts 'Adding News Content'
Content.create(title: 'Leslie Lamport vem à FCT!', link_image: 'LeslieLamport_960.jpg',
               description: 'Leslie Lamport vem dar uma palestra à grandiosa FCT', date: Date.today())
Content.create(title: 'Barbara Liskov vem à FCT!', link_image: 'top-prize.jpg',
               description: 'Barbara Liskov, vencedora do Turing Award, vem dar uma palestra à grandiosa FCT',
               date: Date.today())
Content.create(title: 'Sócia da FCT ganhou prémio!', link_image: 'destaque_4.jpg',
               description: 'Sócia da FCT ganhou 1 Milhão de Euros pela sua investigação.',
               date: Date.today())

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
TagContent.create(content_id: 98, tag_id: 2)

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