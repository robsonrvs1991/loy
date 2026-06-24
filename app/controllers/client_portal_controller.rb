class ClientPortalController < ApplicationController
  skip_before_action :require_barber, raise: false
  before_action :ensure_client_logged_in

  def index
    @customer = current_client
    @barbershop = @customer.barbershop

    @loyalty_program = @barbershop.loyalty_program
    @required_points = @loyalty_program&.required_visits.to_i
    @required_points = 10 if @required_points <= 0

    @points = @customer.loyalty_points.to_i
    @remaining_points = [@required_points - @points, 0].max

    @appointments = @customer.customer_appointments.includes(:service).order(created_at: :desc)
    @rewards = @customer.rewards.order(created_at: :desc)
    @services = @barbershop.services.where(active: true).order(:name)
  end

  private

  def ensure_client_logged_in
    redirect_to cliente_login_path, alert: "Faça login para acessar seu cartão fidelidade." unless current_client
  end
end