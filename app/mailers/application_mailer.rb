class ApplicationMailer < ActionMailer::Base
  include Dry::Monads[:result]

  layout 'mailer'

  def campaign_mail(campaign)
    @message = campaign.message
    recipients = campaign.recipients.pluck(:email)

    mail(
      to: recipients,
      subject: campaign.subject,
      template_path: '/layouts',
      template_name: 'campaign_mail'
    )
  end

  def errors_interceptor
    raise NotImplementedError, 'You schould implement this in particular provider class'
  end
end
