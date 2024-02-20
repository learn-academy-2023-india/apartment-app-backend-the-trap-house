user1 = User.where(email: "test1@example.com").first_or_create(password: "password", password_confirmation: "password")
user2 = User.where(email: "test2@example.com").first_or_create(password: "password", password_confirmation: "password")

user1_apartments = [
  {
    street: "Bikini Bottom Street",
    unit: "1911",
    city: "Miami",
    state: "FL",
    square_footage: 22000,
    price: 25000,
    bedrooms: 8,
    bathrooms: 5,
    pets: "exotic snails only",
    image: "https://static.wikia.nocookie.net/spongebob/images/3/3d/Bottomite_houses.png/revision/latest?cb=20230411233507"
  }
]

user2_apartments = [
  {
    street: "Tiger Way",
    unit: "87",
    city: "Hollywood",
    state: "CA",
    square_footage: 29000,
    price: 40000,
    bedrooms: 11,
    bathrooms: 9,
    pets: "tigers only",
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6mXZfHps8W5S5ITL4VdNCI3gtfVBlWkb9gQ&usqp=CAU"
  }
]

user1_apartments.each do |apartment|
  user1.apartments.create(apartment)
  p "created: #{apartment}"
end

user2_apartments.each do |apartment|
  user2.apartments.create(apartment)
  p "created: #{apartment}"
end