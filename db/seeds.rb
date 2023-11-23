# db/seeds.rb
require 'faker'

# Create 4 non admin users
4.times do |n|
  u = User.create(full_name: Faker::Name.name, email: Faker::Internet.email, password: 'password123')
  u.skip_confirmation!
  u.save
end

# Create admin user
u = User.create(full_name: Faker::Name.name, email: Faker::Internet.email, password: 'admin123', is_admin: '1')
u.skip_confirmation!
u.save

puts 'Seeded 5 into the database'

# Create a company with a title and description
10.times do |n|
  Company.create(name: Faker::Company.name, description: Faker::Company.catch_phrase, email: Faker::Internet.email, user_id: Faker::Number.within(range: 1..6))
end

puts 'Seeded 10 into the database'

# Create project
Project.create(title: 'ProjectX')
Project.create(title: 'ProjectY')

# puts 'Seeded database with Projects: ProjectX and ProjectY'

# # Create tasks with description etc.
# Task.create(name: 'Sort out DNS', description: 'Login to Namecheap', due_date: '23/11/2023', project: 'ProjectX', status: 'pending', reporter: 'John Doe', assigned_to: 'John Doe', team: 'Development')

# puts 'Seeded database with Task: Sort out DNS'
