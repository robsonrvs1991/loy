class LoyaltyProgram < ApplicationRecord
  belongs_to :barbershop
  belongs_to :service, optional: true
  has_many :rewards, dependent: :nullify

  validates :name, presence: true
  validates :required_visits, numericality: { only_integer: true, greater_than: 0 }
  validates :reward_description, presence: true

  scope :active, -> { where(active: true) }

  def applies_to_all_items?
    service_id.blank?
  end
end