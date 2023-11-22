# db/seeds.rb

# Clear existing data from the users table
User.destroy_all
Project.destroy_all

# Create two users with full names
user1 = User.create(full_name: 'John Doe', email: 'john@example.com', password: 'password123')
user2 = User.create(full_name: 'Jane Doe', email: 'jane@example.com', password: 'password456')

puts 'Seeded database with users: John Doe and Jane Doe.'

# Create project
Project.create(title: 'ProjectX')
Project.create(title: 'ProjectY')

puts 'Seeded database with Projects: ProjectX and ProjectY'

# Create tasks with description etc.
Task.create(name: 'Sort out DNS', description: 'Login to Namecheap', due_date: '23/11/2023', project: 'ProjectX', status: 'pending', reporter: 'John Doe', assigned_to: 'John Doe', team: 'Development')

puts 'Seeded database with Task: Sort out DNS'
