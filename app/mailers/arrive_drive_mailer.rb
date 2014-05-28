class ArriveDriveMailer < ActionMailer::Base
  def send_invitation_to_participant(participant, password)
    @participant = participant
    @password = password
    mail(from: Settings.mail.default_url_options.support_email, to: @participant.email, subject: t('mailer.participant.subject.participant'))
  end
end
