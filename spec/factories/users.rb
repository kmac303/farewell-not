FactoryBot.define do
    factory :user do
        first_name { 'John' }
        last_name { 'Doe' }
        username { 'johndoe' }
        date_of_birth { '1988-04-12'.to_date }
        password_digest { BCrypt::Password.create('password123') }
    end
end
