Fabricator(:book) do
  title { Faker::Lorem.words(5).join(" ") }
  author { Faker::Name.name }
  description { Faker::Lorem.paragraph(2) }
end