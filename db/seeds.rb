# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Recipient.destroy_all
Message.destroy_all

# Create 10 fake users
10.times do
    User.create(
      username: Faker::Internet.username,
      password_digest: BCrypt::Password.create('password123'), # Assuming you are using bcrypt for hashing
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65)
    )
  end
  
  # Create 20 fake recipients
  20.times do
    Recipient.create(
      name: Faker::Name.name,
      email: Faker::Internet.email
    )
  end
  
  # Create 30 fake messages
  30.times do
    Message.create(
      subject: Faker::Lorem.sentence(word_count: 3),
      body: Faker::Lorem.paragraph(sentence_count: 5),
      user: User.order(Arel.sql('RANDOM()')).first,
      recipient: Recipient.order(Arel.sql('RANDOM()')).first
    )
  end
  