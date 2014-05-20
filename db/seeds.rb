# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


first_names = ["Zé",
              "António",
              "Carlos",
              "Carlão",
              "Paulo",
              "Paulão",
              "Leonardo",
              "Guilherme",
              "Rafael",
              "Pedro",
              "José"]

last_names = ["Fião",
              "Bizarra",
              "Bizarro",
              "Engatatão",
              "Lopes",
              "Costa",
              "Passos Coelho",
              "Sócrates"]

genders = ["Masculino", "Feminino"]

courses = ["Mestrado Integrado em Engenharia Informatica",
           "Mestrado Integrado em Engenharia Electrotecnica",
          "Mestrado Integrado em Engenharia do Ambiente",
          "Licenciatura em Bioquimica",
          "Licenciatura em Engenharia dos Materiais"]

# USERS name:string birth_date:date gender:string course:string about_me:text
puts "Adding 50 random Users"
1.upto(50) do |i|
  if i == 25
    puts "Done 25, almost there"
  end
  r=Random.rand(10);
  r2=Random.rand(10);
  User.create(
      name: first_names[(r+i)%first_names.length] + " " + last_names[(r2+i)%last_names.length],
      birth_date: Date.today(),
      gender: genders[(r+i)%genders.length],
      course: courses[(r2+i)%courses.length],
      about_me: 'Hehe sou a pessoa número ' + i.to_s + ' e sou muita fixe, hehe',
      email: first_names[(r+i)%first_names.length]+"#{i}"+last_names[(r2+i)%last_names.length]+"@AasdAmail.com",
      password: '123123123',
      password_confirmation: '123123123'
  )
end


