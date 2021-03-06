# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

crime_fiction = Category.create!(name: 'Crime Fiction')
mystery       = Category.create!(name: 'Mystery')
fantasy       = Category.create!(name: 'Fantasy')
equestrian    = Category.create!(name: 'Equestrian')
technology    = Category.create!(name: 'Technology')

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

Book.create!(title: 'Black Beauty',
             author: 'Anna Sewell',
             description: 'A lovely horse abused by cruel humans, finds a happy ending.',
             small_cover_url: '/tmp/black_beauty.jpg',
             category: equestrian)

Book.create!(title: 'The Black Stallion',
             author: 'Walter Farley',
             description: 'A teenage boy and a wild black stallion get stranded on an island, later races to be a champion.',
             small_cover_url: '/tmp/the_black_stallion.jpg',
             category: equestrian)

Book.create!(title: 'Twilight',
             author: 'Stephanie Meyer',
             description: 'A vampire falls in love with a human.',
             small_cover_url: '/tmp/twilight.jpg',
             category: fantasy)

Book.create!(title: 'Eclipse',
             author: 'Stephanie Meyer',
             description: 'A vampire falls in love with a human.',
             small_cover_url: '/tmp/eclipse.jpg',
             category: fantasy)

Book.create!(title: 'Breaking Dawn',
             author: 'Stephanie Meyer',
             description: 'A vampire falls in love with a human.',
             small_cover_url: '/tmp/breaking_dawn.jpg',
             category: fantasy)

Book.create!(title: 'New Moon',
             author: 'Stephanie Meyer',
             description: 'A vampire falls in love with a human.',
             small_cover_url: '/tmp/new_moon.jpg',
             category: fantasy)

da_vinci_code = Book.create!(title: 'The Da Vinci Code',
                             author: 'Dan Brown',
                             description: 'Professor Langdon searches for the Holy Grail.',
                             small_cover_url: '/tmp/the-da-vinci-code.jpg',
                             category: crime_fiction)

test_user = User.create!(email: 'test@abc.com', password: 'password', username: 'Tester')

Review.create!(user: test_user, book: da_vinci_code, rating: 4, content: "This is an excellent book!" )
Review.create!(user: test_user, book: da_vinci_code, rating: 3, content: "This is a good read, but I prefer movies." )