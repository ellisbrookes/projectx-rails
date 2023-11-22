# db/seeds.rb

# Clear existing data from the users table
User.destroy_all

# Create two users with full names
User.create(full_name: 'John Doe', email: 'john@example.com', password: 'password123')
User.create(full_name: 'Jane Doe', email: 'jane@example.com', password: 'password456')

puts 'Seeded database with users: John Doe and Jane Doe.'