require "net/http"
require "json"

class ResendEmailService
  API_URL = "https://api.resend.com/emails".freeze

  def self.deliver!(to:, subject:, html:, text: nil, from: nil)
    new(
      to: to,
      subject: subject,
      html: html,
      text: text,
      from: from
    ).deliver!
  end

  def initialize(to:, subject:, html:, text: nil, from: nil)
    @to = to
    @subject = subject
    @html = html
    @text = text
    @from = from.presence || ENV.fetch("MAIL_FROM", "Loy <noreply@loynow.com>")
  end

  def deliver!
    api_key = ENV.fetch("RESEND_API_KEY")

    uri = URI(API_URL)

    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{api_key}"
    request["Content-Type"] = "application/json"
    request.body = payload.to_json

    response = Net::HTTP.start(
      uri.hostname,
      uri.port,
      use_ssl: true,
      open_timeout: 10,
      read_timeout: 20
    ) do |http|
      http.request(request)
    end

    return true if response.is_a?(Net::HTTPSuccess)

    raise "Resend API error #{response.code}: #{response.body}"
  end

  private

  attr_reader :to, :subject, :html, :text, :from

  def payload
    data = {
      from: from,
      to: [to],
      subject: subject,
      html: html
    }

    data[:text] = text if text.present?

    data
  end
end
