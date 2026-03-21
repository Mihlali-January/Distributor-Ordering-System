puts "Cleaning database..."
OrderItem.destroy_all
Order.destroy_all
Sku.destroy_all
Product.destroy_all
User.destroy_all
Distributor.destroy_all

puts "Creating Admin Users..."
User.create!(
  email: "admin@unionswiss.com",
  username: "biooiladmin",
  first_name: "Head",
  last_name: "Office",
  password: "testing.1234",
  password_confirmation: "testing.1234",
  role: :admin
)
# This
User.create!(
  email: "craig@unionswiss.com",
  username: "craig",
  first_name: "Craig",
  last_name: "Vosloo",
  password: "testing.1234",
  password_confirmation: "testing.1234",
  role: :admin
)

User.create!(
  email: "mihlali@unionswiss.com",
  username: "lisamihlali",
  first_name: "Lisakanya",
  last_name: "January",
  password: "Password.1234",
  password_confirmation: "Password.1234",
  role: :admin
)

puts "Creating Products..."
description = "Clinically proven scar and stretch mark oil."
prod_25ml = Product.create!(name: "Skincare Oil 25ml", volume: "25ml (0.85 oz)", description: description)
prod_60ml = Product.create!(name: "Skincare Oil 60ml", volume: "60ml (2 oz)", description: description)
prod_125ml = Product.create!(name: "Skincare Oil 125ml", volume: "125ml (4.2 oz)", description: description)
prod_200ml = Product.create!(name: "Skincare Oil 200ml", volume: "200ml (6.7 oz)", description: description)

puts "Creating Distributors & Distributor Users..."
# Faker company data(Ruby Gem )

# SOUTH AFRICA
dist_sa = Distributor.create!(
  name: "#{Faker::Company.name} (RSA)",
  distributor_code: "US-SA-001",
  currency: "ZAR",
  contact_name: Faker::Name.name,
  contact_email: Faker::Internet.email,
  contact_phone: Faker::PhoneNumber.phone_number,
  address: "123 Logistics Park, Kyalami, Johannesburg",
  tax_number: "VAT#{Faker::Number.number(digits: 7)}",
  active: true
)

User.create!(
  email: "distributor_sa@domain.com",
  username: "distr0",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  password: "testing.1234",
  password_confirmation: "testing.1234",
  role: :distributor,
  distributor: dist_sa
)

# UNITED KINGDOM
dist_uk = Distributor.create!(
  name: "#{Faker::Company.name} (UK)",
  distributor_code: "US-UK-002",
  currency: "GBP",
  contact_name: Faker::Name.name,
  contact_email: Faker::Internet.email,
  contact_phone: Faker::PhoneNumber.phone_number,
  address: "Unit 4, Thames Gateway, London",
  tax_number: "GB#{Faker::Number.number(digits: 9)}",
  active: true
)

User.create!(
  email: "distributor_uk@domain.com",
  username: "uk_distro",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  password: "testing.1234",
  password_confirmation: "testing.1234",
  role: :distributor,
  distributor: dist_uk
)

# SWEDEN
dist_se = Distributor.create!(
  name: "#{Faker::Company.name} (SE)",
  distributor_code: "US-SE-003",
  currency: "SEK",
  contact_name: Faker::Name.name,
  contact_email: Faker::Internet.email,
  contact_phone: Faker::PhoneNumber.phone_number,
  address: "Hamngatan 37, 111 47 Stockholm, Sweden",
  tax_number: "SE#{Faker::Number.number(digits: 12)}",
  active: true
)

User.create!(
  email: "distributor_se@domain.com",
  username: "#{Faker::Name.first_name}007",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  password: "testing.1234",
  password_confirmation: "testing.1234",
  role: :distributor,
  distributor: dist_se
)

puts "Creating SKUs..."
# SA Pricing (ZAR)
Sku.create!(product: prod_25ml, distributor: dist_sa, price_per_unit: 50.00)
Sku.create!(product: prod_60ml, distributor: dist_sa, price_per_unit: 100.00)
Sku.create!(product: prod_125ml, distributor: dist_sa, price_per_unit: 150.00)
Sku.create!(product: prod_200ml, distributor: dist_sa, price_per_unit: 250.00)

# UK Pricing (GBP)
Sku.create!(product: prod_25ml, distributor: dist_uk, price_per_unit: 4.00)
Sku.create!(product: prod_60ml, distributor: dist_uk, price_per_unit: 8.00)
Sku.create!(product: prod_125ml, distributor: dist_uk, price_per_unit: 15.00)
Sku.create!(product: prod_200ml, distributor: dist_uk, price_per_unit: 20.00)

# Sweden Pricing (SEK)
Sku.create!(product: prod_25ml, distributor: dist_se, price_per_unit: 28.00)
Sku.create!(product: prod_60ml, distributor: dist_se, price_per_unit: 56.00)
Sku.create!(product: prod_125ml, distributor: dist_se, price_per_unit: 84.00)
Sku.create!(product: prod_200ml, distributor: dist_se, price_per_unit: 140.00)

puts "Creating Orders..."
# This is seed data; for the DEMO ( having an example of what it would look)
# Three orders that are there to genreate the data

# SA ORDER 1
order_sa = Order.new(
  distributor: dist_sa,
  user: dist_sa.users.first,
  required_delivery_date: 2.weeks.from_now
)
order_sa.order_items.build(sku: dist_sa.skus.find_by(product: prod_25ml), pallets: 30)
order_sa.order_items.build(sku: dist_sa.skus.find_by(product: prod_200ml), pallets: 10)
order_sa.save!

# UK ORDER 1
order_uk = Order.new(
  distributor: dist_uk,
  user: dist_uk.users.first,
  required_delivery_date: 3.weeks.from_now
)
order_uk.order_items.build(sku: dist_uk.skus.find_by(product: prod_125ml), pallets: 12)
order_uk.save!

# SWEDEN ORDER 1
order_se = Order.new(
  distributor: dist_se,
  user: dist_se.users.first,
  required_delivery_date: 10.days.from_now
)
order_se.order_items.build(sku: dist_se.skus.find_by(product: prod_25ml), pallets: 8)
order_se.order_items.build(sku: dist_se.skus.find_by(product: prod_60ml), pallets: 8)
order_se.save!

puts "Seed data successfully created..."
