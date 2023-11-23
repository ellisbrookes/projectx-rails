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

puts 'Seeded 4 users and 1 admin user into the database'

# Create a company with a title and description
10.times do |n|
  Company.create(name: Faker::Company.name, description: Faker::Company.catch_phrase, email: Faker::Internet.email, user_id: Faker::Number.within(range: 1..6))
end

puts 'Seeded 10 companies into the database'


# Create team
10.times do |n|
  Team.create(
    name: Faker::Team.name,
    description: Faker::Company.catch_phrase,
    team_email: Faker::Internet.email,
    company_id: Faker::Number.within(range: 1..6)
    )
  end
  
  puts 'Seeded 10 teams in the database'
  
  # Create project
  10.times do |n|
    Project.create(
      title: Faker::Company.name,
      description: Faker::Company.catch_phrase,
      start_date: Faker::Date.backward(days: 30),
      completion_date: Faker::Date.forward(days: 30),
      team_id: Faker::Number.within(range: 1..6),
      company_id: Faker::Number.within(range: 1..6),
      estimated_budget: Faker::Commerce.price,
      actual_budget: Faker::Commerce.price
    )
  end
  
  puts 'Seeded 10 projects into the database'
  
  # Create tasks with description etc.
  # Task.create(name: 'Sort out DNS', description: 'Login to Namecheap', due_date: '23/11/2023', project: 'ProjectX', status: 'pending', reporter: 'John Doe', assigned_to: 'John Doe', team: 'Development')
  
  # puts 'Seeded database with Task: Sort out DNS'
  