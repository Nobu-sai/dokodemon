# Users
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# Blogs
users = User.order(:created_at).take(6)
50.times do
  title = Faker::Quote.famous_last_words
  text = Faker::Lorem.paragraphs(number: rand(2..10)).join('\r\n').gsub(/[\\r\\n]/, "\r\n")
  users.each { |user| user.blogs.create!(title: title, text: text) }
end

# Create following relationships.
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# Places
Place.create!(name:  "Example Place")

99.times do |n|
  name  = Faker::Name.name
  Place.create!(name:  name)
end


# PlaceComments
# place = Place.order(:created_at).take(6)
# 50.times do
#   content = Faker::Lorem.sentence(5)
#   places.each { |user| place.place_comments.create!(content: content) }
# end
