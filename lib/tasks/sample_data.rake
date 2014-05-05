namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end
#    admin = User.create!(
#                         firstname: "Example",
#                         lastname: "User",
#                         name: "Example User",
#                         email: "example@fakebook.org",
#                         password: "foobar",
#                         password_confirmation: "foobar",
#                         admin: true)
def make_users
  admin = User.create!(firstname: "Chris",
                       lastname: "Hack",
                       name: "Chris Hack",
                       email: "hack@colorado.edu",
                       password: "abcd1234",
                       password_confirmation: "abcd1234",
                       admin: true)
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
  end
  def make_microposts
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
  
def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end