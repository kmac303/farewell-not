# Create 10 fake users
10.times do
  User.create(
    username: Faker::Internet.username,
    password: "whatever",
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
  message = Message.create(
    subject: Faker::Lorem.sentence(word_count: 3),
    body: Faker::Lorem.paragraph(sentence_count: 5),
    user: User.order(Arel.sql('RANDOM()')).first
  )
  
  # Create a MessageRecipient for each message
  MessageRecipient.create(
    message: message,
    recipient: Recipient.order(Arel.sql('RANDOM()')).first
  )
end