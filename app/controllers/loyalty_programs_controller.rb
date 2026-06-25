class LoyaltyProgramsController < ApplicationController
  before_action :require_login
  before_action :require_barber
  before_action :set_loyalty_program, only: [:show, :edit, :update, :destroy]

  def index
    @loyalty_programs = current_user.barbershop
                                     .loyalty_programs
                                     .includes(:service)
                                     .order(active: :desc, created_at: :desc)
  end

  def show
  end

  def new
    @loyalty_program = current_user.barbershop.loyalty_programs.new(
      name: "Novo programa",
      required_visits: 10,
      reward_description: "Recompensa grátis",
      active: true
    )

    load_services
  end

  def create
    @loyalty_program = current_user.barbershop.loyalty_programs.new(loyalty_program_params)

    if @loyalty_program.save
      redirect_to loyalty_programs_path, notice: "Programa de fidelidade criado com sucesso."
    else
      load_services
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    load_services
  end

  def update
    if @loyalty_program.update(loyalty_program_params)
      redirect_to loyalty_programs_path, notice: "Programa de fidelidade atualizado."
    else
      load_services
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @loyalty_program.update!(active: false)

    redirect_to loyalty_programs_path, notice: "Programa desativado com sucesso."
  end

  private

  def set_loyalty_program
    @loyalty_program = current_user.barbershop.loyalty_programs.find(params[:id])
  end

  def load_services
    @services = current_user.barbershop.services.where(active: true).order(:name)
  end

  def loyalty_program_params
    params.require(:loyalty_program).permit(
      :name,
      :service_id,
      :required_visits,
      :reward_description,
      :active
    )
  end
end