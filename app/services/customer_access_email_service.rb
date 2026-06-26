class CustomerAccessEmailService
  def self.deliver!(customer:, temporary_password:, company:, login_url:)
    new(
      customer: customer,
      temporary_password: temporary_password,
      company: company,
      login_url: login_url
    ).deliver!
  end

  def initialize(customer:, temporary_password:, company:, login_url:)
    @customer = customer
    @temporary_password = temporary_password
    @company = company
    @login_url = login_url
  end

  def deliver!
    ResendEmailService.deliver!(
      to: customer.email,
      subject: "Seu acesso ao cartão fidelidade está disponível",
      html: html_body,
      text: text_body
    )
  end

  private

  attr_reader :customer, :temporary_password, :company, :login_url

  def html_body
    <<~HTML
      <h2>Seu cartão fidelidade digital está disponível</h2>

      <p>Olá, #{customer.name}!</p>

      <p>
        A empresa <strong>#{company.name}</strong> criou seu acesso ao cartão fidelidade digital.
      </p>

      <p><strong>E-mail:</strong> #{customer.email}</p>
      <p><strong>Senha provisória:</strong> #{temporary_password}</p>

      <p>
        Acesse seu cartão fidelidade:
        <br>
        <a href="#{login_url}">#{login_url}</a>
      </p>

      <p>Recomendamos alterar sua senha após o primeiro acesso.</p>

      <p>Equipe Loy</p>
    HTML
  end

  def text_body
    <<~TEXT
      Seu cartão fidelidade digital está disponível

      Olá, #{customer.name}!

      A empresa #{company.name} criou seu acesso.

      E-mail: #{customer.email}
      Senha provisória: #{temporary_password}

      Acesse:
      #{login_url}

      Recomendamos alterar sua senha após o primeiro acesso.

      Equipe Loy
    TEXT
  end
end
