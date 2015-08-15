# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

crime_fiction = Category.create!(name: 'Crime Fiction')
mystery = Category.create!(name: 'Mystery')
technology = Category.create!(name: 'Technology')

Book.create!(title: 'Lord of the Flies',
             author: 'William Golding',
             description: 'Boys stuck on an island descend into savagery as they try to establish a chain of authority.',
             small_cover_url: '/tmp/lord-of-the-flies.jpg',
             category: mystery)

Book.create!(title: 'Coding for Dummies',
             author: 'Nikhil Abraham',
             description: 'Learn to code like a pro.',
             small_cover_url: '/tmp/coding-for-dummies.jpg',
             category: technology)

Book.create!(title: 'The Girl with the Dragon Tattoo',
             author: 'Stieg Larsson',
             description: 'Investigative reporter and troubled, but brilliant hacker team up to solve a 40 year old murder mystery.',
             small_cover_url: '/tmp/girl-with-the-dragon-tattoo.jpg',
             category: crime_fiction)

Book.create!(title: 'The Da Vinci Code',
             author: 'Dan Brown',
             description: 'Professor Langdon searches for the Holy Grail.',
             small_cover_url: '/tmp/the-da-vinci-code.jpg',
             category: crime_fiction)

test_user = User.create!(email: 'test@abc.com', password: 'password', username: 'Tester')