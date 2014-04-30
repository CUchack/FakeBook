namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
#    admin = User.create!(
#                         firstname: "Example",
#                         lastname: "User",
#                         name: "Example User",
#                         email: "example@fakebook.org",
#                         password: "foobar",
#                         password_confirmation: "foobar",
#                         admin: true)
    User.create!(firstname: "Example",
                 lastname: "User",
                 name: "Example User",
                 email: "example@fakebook.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      firstname = Faker::Name.name
      lastname = Faker::Name.name
      name  = Faker::Name.name
      email = "example-#{n+1}@fakebook.org"
      password  = "password"
      User.create!(
                   firstname: firstname,
                   lastname: lastname,
                   name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
end