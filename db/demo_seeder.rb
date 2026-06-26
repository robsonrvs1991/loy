# frozen_string_literal: true

# Executar local:
# bin/rails runner db/demo_seeder.rb
#
# Executar produção:
# RAILS_ENV=production bin/rails runner db/demo_seeder.rb

class DemoSeeder
  DEFAULT_PASSWORD = "123456"

  def self.run
    new.run
  end

  def run
    puts "======================================"
    puts "Criando ambiente demo do Loy"
    puts "======================================"

    create_demo_company(
      name: "Bella Flora",
      email: "floricultura@loy.test",
      owner_name: "Marina Flores",
      phone: "48991234567",
      services: [
        ["Buquê de Rosas", 1],
        ["Arranjo de Mesa", 1],
        ["Cesta Especial", 2],
        ["Orquídea Presente", 2],
        ["Decoração Pequena", 3]
      ],
      customers: [
        ["Juliana Castro", "juliana.floricultura@loy.test", "48990010001"],
        ["Ana Carolina", "ana.floricultura@loy.test", "48990010002"],
        ["Fernanda Rocha", "fernanda.floricultura@loy.test", "48990010003"],
        ["Eduarda Lima", "eduarda.floricultura@loy.test", "48990010004"],
        ["Daniel Martins", "daniel.floricultura@loy.test", "48990010005"],
        ["Camila Souza", "camila.floricultura@loy.test", "48990010006"],
        ["Lucas Vieira", "lucas.floricultura@loy.test", "48990010007"],
        ["Patrícia Gomes", "patricia.floricultura@loy.test", "48990010008"]
      ],
      reward_description: "Arranjo Premium",
      required_points: 10
    )

    create_demo_company(
      name: "Vitor Barber Demo",
      email: "barbearia@loy.test",
      owner_name: "Vitor Barber",
      phone: "48991112222",
      services: [
        ["Corte Masculino", 1],
        ["Barba", 1],
        ["Corte + Barba", 2],
        ["Sobrancelha", 1],
        ["Hidratação", 2]
      ],
      customers: [
        ["Rafael Mendes", "rafael.barbearia@loy.test", "48990020001"],
        ["Bruno Henrique", "bruno.barbearia@loy.test", "48990020002"],
        ["Felipe Costa", "felipe.barbearia@loy.test", "48990020003"],
        ["Marcos Paulo", "marcos.barbearia@loy.test", "48990020004"],
        ["Thiago Alves", "thiago.barbearia@loy.test", "48990020005"],
        ["João Pedro", "joao.barbearia@loy.test", "48990020006"],
        ["André Luiz", "andre.barbearia@loy.test", "48990020007"],
        ["Gustavo Rocha", "gustavo.barbearia@loy.test", "48990020008"]
      ],
      reward_description: "Corte grátis",
      required_points: 10
    )

    create_demo_company(
      name: "Pet Feliz",
      email: "petshop@loy.test",
      owner_name: "Carla Pet",
      phone: "48992223333",
      services: [
        ["Banho", 1],
        ["Tosa Higiênica", 1],
        ["Banho + Tosa", 2],
        ["Hidratação Pet", 2],
        ["Pacote Mensal", 3]
      ],
      customers: [
        ["Amanda Ribeiro", "amanda.petshop@loy.test", "48990030001"],
        ["Rodrigo Nunes", "rodrigo.petshop@loy.test", "48990030002"],
        ["Larissa Melo", "larissa.petshop@loy.test", "48990030003"],
        ["Vanessa Duarte", "vanessa.petshop@loy.test", "48990030004"],
        ["Paulo Cesar", "paulo.petshop@loy.test", "48990030005"],
        ["Bianca Torres", "bianca.petshop@loy.test", "48990030006"],
        ["Renata Alves", "renata.petshop@loy.test", "48990030007"],
        ["Igor Santana", "igor.petshop@loy.test", "48990030008"]
      ],
      reward_description: "Banho grátis",
      required_points: 8
    )

    create_demo_company(
      name: "Lava Car Premium",
      email: "lavacar@loy.test",
      owner_name: "Marcelo Lava Car",
      phone: "48993334444",
      services: [
        ["Lavagem Simples", 1],
        ["Lavagem Completa", 2],
        ["Higienização Interna", 3],
        ["Polimento", 3],
        ["Cristalização", 4]
      ],
      customers: [
        ["Carlos Eduardo", "carlos.lavacar@loy.test", "48990040001"],
        ["Sabrina Lopes", "sabrina.lavacar@loy.test", "48990040002"],
        ["Diego Fernandes", "diego.lavacar@loy.test", "48990040003"],
        ["Priscila Ramos", "priscila.lavacar@loy.test", "48990040004"],
        ["Henrique Lima", "henrique.lavacar@loy.test", "48990040005"],
        ["Tatiane Moura", "tatiane.lavacar@loy.test", "48990040006"],
        ["Alexandre Reis", "alexandre.lavacar@loy.test", "48990040007"],
        ["Roberta Dias", "roberta.lavacar@loy.test", "48990040008"]
      ],
      reward_description: "Lavagem completa grátis",
      required_points: 10
    )

    create_demo_company(
      name: "Academia Movimento",
      email: "academia@loy.test",
      owner_name: "Priscila Fitness",
      phone: "48994445555",
      services: [
        ["Mensalidade", 2],
        ["Avaliação Física", 1],
        ["Personal Avulso", 2],
        ["Plano Trimestral", 4],
        ["Aula Experimental", 1]
      ],
      customers: [
        ["Gabriela Martins", "gabriela.academia@loy.test", "48990050001"],
        ["Mateus Silva", "mateus.academia@loy.test", "48990050002"],
        ["Letícia Costa", "leticia.academia@loy.test", "48990050003"],
        ["Vinícius Oliveira", "vinicius.academia@loy.test", "48990050004"],
        ["Caroline Santos", "caroline.academia@loy.test", "48990050005"],
        ["Eduardo Freitas", "eduardo.academia@loy.test", "48990050006"],
        ["Isabela Rocha", "isabela.academia@loy.test", "48990050007"],
        ["Leonardo Souza", "leonardo.academia@loy.test", "48990050008"]
      ],
      reward_description: "1 semana grátis",
      required_points: 12
    )

    create_demo_company(
      name: "Café Aroma",
      email: "cafeteria@loy.test",
      owner_name: "Helena Café",
      phone: "48995556666",
      services: [
        ["Café Espresso", 1],
        ["Cappuccino", 1],
        ["Combo Café + Doce", 2],
        ["Brunch Especial", 3],
        ["Café Gelado", 1]
      ],
      customers: [
        ["Mariana Teixeira", "mariana.cafeteria@loy.test", "48990060001"],
        ["Pedro Henrique", "pedro.cafeteria@loy.test", "48990060002"],
        ["Natália Ferreira", "natalia.cafeteria@loy.test", "48990060003"],
        ["Caio Ribeiro", "caio.cafeteria@loy.test", "48990060004"],
        ["Luana Barbosa", "luana.cafeteria@loy.test", "48990060005"],
        ["Fernando Melo", "fernando.cafeteria@loy.test", "48990060006"],
        ["Aline Vieira", "aline.cafeteria@loy.test", "48990060007"],
        ["Ricardo Campos", "ricardo.cafeteria@loy.test", "48990060008"]
      ],
      reward_description: "Combo café especial grátis",
      required_points: 10
    )

    puts
    puts "======================================"
    puts "Demo criada com sucesso!"
    puts "======================================"
    puts
    puts "Credenciais:"
    puts "Floricultura: floricultura@loy.test / #{DEFAULT_PASSWORD}"
    puts "Barbearia:    barbearia@loy.test / #{DEFAULT_PASSWORD}"
    puts "Pet Shop:     petshop@loy.test / #{DEFAULT_PASSWORD}"
    puts "Lava Car:     lavacar@loy.test / #{DEFAULT_PASSWORD}"
    puts "Academia:     academia@loy.test / #{DEFAULT_PASSWORD}"
    puts "Cafeteria:    cafeteria@loy.test / #{DEFAULT_PASSWORD}"
    puts
  end

  private

  def create_demo_company(name:, email:, owner_name:, phone:, services:, customers:, reward_description:, required_points:)
    puts
    puts "Criando demo: #{name}"

    company = Barbershop.find_or_initialize_by(name: name)
    assign_if_column(company, :phone, phone)
    assign_if_column(company, :address, "Rua Demo, 100 - Centro")
    assign_if_column(company, :email, email)
    assign_if_column(company, :company_email, email)
    assign_if_column(company, :company_phone, phone)
    assign_if_column(company, :responsible_name, owner_name)
    assign_if_column(company, :owner_name, owner_name)
    assign_if_column(company, :plan, "monthly")
    assign_if_column(company, :subscription_status, "active")
    assign_if_column(company, :status, "active")
    assign_if_column(company, :blocked, false)
    assign_if_column(company, :monthly_price, 19.90)
    assign_if_column(company, :trial_ends_at, 30.days.from_now)
    company.save!

    create_subscription(company)

    owner = User.find_or_initialize_by(email: email)
    owner.name = owner_name
    owner.phone = phone if owner.respond_to?(:phone=)
    owner.role = "barber"
    owner.barbershop = company if owner.respond_to?(:barbershop=)
    owner.password = DEFAULT_PASSWORD
    owner.password_confirmation = DEFAULT_PASSWORD
    owner.save!

    service_records = services.map do |service_name, points|
      service = company.services.find_or_initialize_by(name: service_name)
      service.points = points if service.respond_to?(:points=)
      service.active = true if service.respond_to?(:active=)
      service.save!
      service
    end

    loyalty_program = company.loyalty_programs.find_or_initialize_by(reward_description: reward_description)
    assign_if_column(loyalty_program, :name, "Programa Fidelidade #{name}")
    assign_if_column(loyalty_program, :required_visits, required_points)
    assign_if_column(loyalty_program, :required_points, required_points)
    assign_if_column(loyalty_program, :points_required, required_points)
    assign_if_column(loyalty_program, :goal_points, required_points)
    assign_if_column(loyalty_program, :active, true)
    assign_if_column(loyalty_program, :reward_description, reward_description)
    loyalty_program.save!

    customer_records = customers.map do |customer_name, customer_email, customer_phone|
      customer = User.find_or_initialize_by(email: customer_email)
      customer.name = customer_name
      customer.phone = customer_phone if customer.respond_to?(:phone=)
      customer.role = "customer"
      customer.barbershop = company if customer.respond_to?(:barbershop=)
      customer.password = DEFAULT_PASSWORD
      customer.password_confirmation = DEFAULT_PASSWORD
      customer.save!
      customer
    end

    create_appointments(company, customer_records, service_records)
    refresh_customer_points(company, customer_records)
    create_rewards(company, customer_records, reward_description)

    puts "OK: #{name}"
  end

  def create_subscription(company)
    return unless defined?(Subscription)
    return unless company.respond_to?(:subscription)

    subscription = company.subscription || company.build_subscription
    assign_if_column(subscription, :status, "active")
    assign_if_column(subscription, :plan, "monthly")
    assign_if_column(subscription, :price, 19.90)
    assign_if_column(subscription, :amount, 19.90)
    assign_if_column(subscription, :current_period_ends_at, 30.days.from_now)
    assign_if_column(subscription, :trial_ends_at, 30.days.from_now)
    subscription.save!
  rescue StandardError => e
    puts "Aviso: não foi possível criar assinatura para #{company.name}: #{e.message}"
  end

  def create_appointments(company, customers, services)
    return if customers.empty? || services.empty?

    base_dates = [
      5.months.ago,
      4.months.ago,
      3.months.ago,
      2.months.ago,
      1.month.ago,
      20.days.ago,
      10.days.ago,
      3.days.ago
    ]

    customers.each_with_index do |customer, customer_index|
      base_dates.each_with_index do |base_date, date_index|
        service = services[(customer_index + date_index) % services.size]
        created_at = base_date.change(hour: 9 + (date_index % 8), min: [0, 15, 30, 45][date_index % 4])

        appointment = Appointment.find_or_initialize_by(
          barbershop_id: company.id,
          customer_id: customer.id,
          service_id: service.id,
          created_at: created_at
        )

        assign_if_column(appointment, :paid, true)
        assign_if_column(appointment, :points, service.respond_to?(:points) ? service.points.to_i : 1)
        assign_if_column(appointment, :notes, "Atendimento demo gerado automaticamente")
        appointment.save!
      end
    end
  end

  def refresh_customer_points(company, customers)
    customers.each do |customer|
      points = Appointment.where(barbershop_id: company.id, customer_id: customer.id)
                          .joins(:service)
                          .sum("services.points")

      if customer.respond_to?(:loyalty_points=)
        customer.update!(loyalty_points: points)
      end
    end
  rescue StandardError => e
    puts "Aviso: não foi possível atualizar pontos: #{e.message}"
  end

  def create_rewards(company, customers, reward_description)
    customers.first(4).each_with_index do |customer, index|
      code = "LOY-DEMO-#{company.id}-#{customer.id}-#{index + 1}"

      reward = Reward.find_or_initialize_by(code: code)
      reward.barbershop = company if reward.respond_to?(:barbershop=)
      reward.customer = customer if reward.respond_to?(:customer=)
      assign_if_column(reward, :description, reward_description)
      assign_if_column(reward, :earned_at, (15 - index).days.ago)
      assign_if_column(reward, :used, index.even?)

      if reward.respond_to?(:used_at=)
        reward.used_at = index.even? ? (10 - index).days.ago : nil
      end

      reward.save!
    end
  end

  def assign_if_column(record, attribute, value)
    setter = "#{attribute}="
    record.public_send(setter, value) if record.respond_to?(setter)
  end
end

DemoSeeder.run
