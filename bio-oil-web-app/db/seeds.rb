puts "Cleaning database..."
OrderItem.destroy_all
Order.destroy_all
Sku.destroy_all
Product.destroy_all
User.destroy_all
Distributor.destroy_all

puts "Creating Admin User..."
User.create!(
  email: "admin@unionswiss.com",
  password: "headOffice1234",
  password_confirmation: "headOffice1234",
  role: :admin
)

User.create!(
  email: "craig@unionswiss.com",
  password: "Letsinnovate1234",
  password_confirmation: "Letsinnovate1234",
  role: :admin
)

User.create!(
  email: "mihlali@unionswiss.com",
  password: "Letsinnovate1234",
  password_confirmation: "Letsinnovate1234",
  role: :admin
)

puts "Creating Products..."
prod_60ml = Product.create!(name: "Skincare Oil 60ml", volume: "60ml")
prod_125ml = Product.create!(name: "Skincare Oil 125ml", volume: "125ml")
prod_200ml = Product.create!(name: "Skincare Oil 200ml", volume: "200ml")

puts "Creating Distributors & Distributor Users..."
dist_sa = Distributor.create!(name: "South Africa Distribution", currency: "ZAR")
User.create!(
  email: "distributor_sa@example.com",
  password: "distr0SA1234",
  password_confirmation: "distr0SA1234",
  role: :distributor,
  distributor: dist_sa
)

dist_uk = Distributor.create!(name: "UK Distribution", currency: "GBP")
User.create!(
  email: "distributor_uk@example.com",
  password: "distr0UK1234",
  password_confirmation: "distr0UK1234",
  role: :distributor,
  distributor: dist_uk
)

puts "Creating SKUs..."
# SA Pricing
Sku.create!(product: prod_60ml, distributor: dist_sa, price_per_unit: 100.00)
Sku.create!(product: prod_125ml, distributor: dist_sa, price_per_unit: 200.00)

# UK Pricing
Sku.create!(product: prod_60ml, distributor: dist_uk, price_per_unit: 10.00)
Sku.create!(product: prod_200ml, distributor: dist_uk, price_per_unit: 20.00)

puts "Seed data successfully created!"
