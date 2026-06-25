class Reward < ApplicationRecord
  belongs_to :barbershop
  belongs_to :customer, class_name: "User"
  belongs_to :loyalty_program, optional: true

  before_validation :generate_code, on: :create

  validates :code, presence: true, uniqueness: true

  def self.create_if_earned!(customer, barbershop, service: nil)
    programs = barbershop.loyalty_programs.active

    programs = programs.where(service_id: [nil, service&.id])

    programs.find_each do |program|
      create_for_program_if_earned!(customer, barbershop, program)
    end
  end

  def self.create_for_program_if_earned!(customer, barbershop, program)
    required_points = program.required_visits

    appointments = barbershop.appointments.where(customer: customer)
    appointments = appointments.where(service_id: program.service_id) if program.service_id.present?

    total_points = appointments.sum(:points)

    rewards_count = barbershop.rewards
                               .where(customer: customer, loyalty_program: program)
                               .count

    already_used_points = rewards_count * required_points

    return if total_points < already_used_points + required_points

    create!(
      barbershop: barbershop,
      customer: customer,
      loyalty_program: program,
      description: program.reward_description,
      used: false,
      earned_at: Time.current
    )
  end

  private

  def generate_code
    return if code.present?

    loop do
      self.code = "LOY-#{SecureRandom.alphanumeric(6).upcase}"
      break unless Reward.exists?(code: code)
    end
  end
end