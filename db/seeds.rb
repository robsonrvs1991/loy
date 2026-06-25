barbershop = Barbershop.first_or_create!(
  name: "Vitor Barber",
  phone: "48984360646",
  address: "Rua Bento Silveira 170"
)

barber = User.find_or_initialize_by(email: "admin@barber.test")
barber.assign_attributes(
  name: "Barbeiro Admin",
  phone: "48999999999",
  role: "barber",
  barbershop: barbershop,
  password: "123456",
  password_confirmation: "123456"
)
barber.save!

customer = User.find_or_initialize_by(email: "cliente@barber.test")
customer.assign_attributes(
  name: "Cliente Exemplo",
  phone: "48988888888",
  role: "customer",
  barbershop: barbershop,
  password: "123456",
  password_confirmation: "123456"
)
customer.save!

[
  ["Corte", 1],
  ["Corte + Barba", 1],
  ["Corte Premium", 1],
  ["Barba", 1]
].each do |name, points|
  service = Service.find_or_initialize_by(name: name, barbershop: barbershop)
  service.active = true
  service.points = points
  service.save!
end

program = LoyaltyProgram.find_or_initialize_by(barbershop: barbershop)
program.required_visits = 10
program.reward_description = "Corte grátis"
program.save!

owner = User.find_or_initialize_by(email: "ldcmiudo@gmail.com")
owner.assign_attributes(
  name: "Robson",
  role: "owner",
  barbershop_id: nil,
  password: "123456",
  password_confirmation: "123456"
)
owner.save!