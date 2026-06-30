class CompanyAccessEmailService
  def self.deliver!(user:, company:, login_url:, password: nil)
    new(
      user: user,
      company: company,
      login_url: login_url,
      password: password
    ).deliver!
  end

  def initialize(user:, company:, login_url:, password: nil)
    @user = user
    @company = company
    @login_url = login_url
    @password = password
  end

  def deliver!
    ResendEmailService.deliver!(
      to: user.email,
      subject: "Seu acesso ao Loy está disponível",
      html: html_body,
      text: text_body
    )
  end

  private

  attr_reader :user, :company, :login_url, :password

  def html_body
    password_html = if password.present?
                      "<p><strong>Senha:</strong> #{password}</p>"
                    else
                      ""
                    end

    <<~HTML
      <h2>Seu acesso ao Loy está disponível</h2>

      <p>Olá, #{user.name}!</p>

      <p>
        A empresa <strong>#{company.name}</strong> está cadastrada no Loy.
      </p>

      <p>
        <strong>Login:</strong> #{user.email}
      </p>

      #{password_html}

      <p>
        Acesse o painel pelo link abaixo:<br>
        <a href="#{login_url}">#{login_url}</a>
      </p>

      <p>
        No painel você poderá cadastrar clientes, itens/serviços, programas de fidelidade e recompensas.
      </p>

      <p>Equipe Loy</p>
    HTML
  end

  def text_body
    password_text = password.present? ? "Senha: #{password}\n\n" : ""

    <<~TEXT
      Seu acesso ao Loy está disponível

      Olá, #{user.name}!

      A empresa #{company.name} está cadastrada no Loy.

      Login: #{user.email}
      #{password_text}Acesse o painel:
      #{login_url}

      No painel você poderá cadastrar clientes, itens/serviços, programas de fidelidade e recompensas.

      Equipe Loy
    TEXT
  end
end