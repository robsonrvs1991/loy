class CustomersController < ApplicationController
  before_action :require_login
  before_action :require_barber
  before_action :require_active_subscription
  before_action :set_customer, only: [:show, :edit, :update, :destroy, :update_password]

  def index
    @page = params[:page].to_i
    @page = 1 if @page < 1

    @per_page = 10

    customers_scope = current_barbershop.users
                                      .where(role: "customer")
                                      .order(:name)

    @total_customers = customers_scope.count
    @total_pages = (@total_customers.to_f / @per_page).ceil
    @total_pages = 1 if @total_pages < 1

    @page = @total_pages if @page > @total_pages

    @customers = customers_scope
                 .offset((@page - 1) * @per_page)
                 .limit(@per_page)
  end

  def show
    @appointments = Appointment.where(customer_id: @customer.id).order(created_at: :desc)
    @rewards = Reward.where(customer_id: @customer.id).order(created_at: :desc)
  end

  def new
    @customer = current_barbershop.users.new(role: "customer")
  end

  def create
    @customer = current_barbershop.users.new(customer_params)
    @customer.role = "customer"
    @temporary_password = SecureRandom.alphanumeric(8)
    @customer.password = @temporary_password
    @customer.password_confirmation = @temporary_password
    @customer.email = @customer.email.to_s.downcase

    if @customer.save
      email_sent = send_customer_access_email(@temporary_password)

      flash[:customer_access] = {
        name: @customer.name,
        email: @customer.email,
        password: @temporary_password,
        login_url: "#{request.base_url}/cliente/login",
        portal_url: "#{request.base_url}/cliente"
      }

      notice_message = if email_sent
                         "Cliente cadastrado. O acesso também está disponível para copiar e enviar."
                       else
                         "Cliente cadastrado, mas não foi possível enviar o e-mail. Copie os dados de acesso abaixo."
                       end

      redirect_to customer_path(@customer), notice: notice_message
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    attrs = customer_params
    attrs[:email] = attrs[:email].to_s.downcase if attrs[:email].present?

    if @customer.update(attrs)
      redirect_to customer_path(@customer), notice: "Cliente atualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_password
    password = params[:user][:password].to_s
    password_confirmation = params[:user][:password_confirmation].to_s
    send_email = params[:send_email].present?

    if password.blank?
      redirect_to customer_path(@customer), alert: "Informe a nova senha."
      return
    end

    if password != password_confirmation
      redirect_to customer_path(@customer), alert: "A confirmação da senha não confere."
      return
    end

    if password.length < 6
      redirect_to customer_path(@customer), alert: "A senha deve ter pelo menos 6 caracteres."
      return
    end

    if @customer.update(
      password: password,
      password_confirmation: password_confirmation
    )
      email_sent = send_email ? send_customer_access_email(password) : true

      flash[:customer_access] = {
        name: @customer.name,
        email: @customer.email,
        password: password,
        login_url: "#{request.base_url}/cliente/login",
        portal_url: "#{request.base_url}/cliente"
      }

      notice_message = if send_email && !email_sent
                         "Senha alterada, mas não foi possível enviar o e-mail. Copie os dados de acesso abaixo."
                       else
                         "Senha alterada com sucesso. Os dados de acesso estão disponíveis para copiar."
                       end

      redirect_to customer_path(@customer), notice: notice_message
    else
      redirect_to customer_path(@customer),
                  alert: "Não foi possível alterar a senha."
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path, notice: "Cliente removido."
  end

  private

  def set_customer
    @customer = current_barbershop.users
                                 .where(role: "customer")
                                 .find(params[:id])
  end

  def customer_params
    params.require(:user).permit(:name, :email, :phone)
  end

  def send_customer_access_email(password)
    CustomerAccessEmailService.deliver!(
      customer: @customer,
      temporary_password: password,
      company: current_barbershop,
      login_url: "#{request.base_url}/cliente/login"
    )

    true
  rescue StandardError => e
    Rails.logger.error("[CustomerAccessEmailService] Falha ao enviar acesso: #{e.class} - #{e.message}")
    false
  end
end