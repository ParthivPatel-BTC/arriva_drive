class ArriveDriveMailer < ActionMailer::Base
  def send_invitation_to_participant(participant, password)
    @participant = participant
    @password = password
    mail(from: Settings.mail.default_url_options.support_email, to: @participant.email, subject: t('mailer.participant.subject.welcome'))
  end

  def send_shared_notification(attachment, participant)
    @participant = participant
    mail.attachments[attachment.attachment_file_name] = File.read("public/system/participant_attachments/#{attachment.id}/#{attachment.attachment_file_name}")
    mail(from: Settings.mail.default_url_options.support_email, to: @participant.email, subject: t('mailer.participant.subject.shared_notification'))
  end

  def send_notification_to_participant(note_content, participant)
  	@participant = participant
  	@note_content = note_content
  	mail(from: Settings.mail.default_url_options.support_email, to: @participant.email, subject: t('mailer.participant.subject.welcome'))
  end
end
