class ArriveDriveMailer < ActionMailer::Base
  def send_invitation_to_participant(participant, password)
    @participant = participant
    @password = password
    mail(from: Settings.mail.default_url_options.support_email, to: @participant.email, subject: t('mailer.participant.subject.welcome'))
  end

  # Attachment shared
  def send_shared_notification(attachment, participant, current_participant)
    @participant = participant
    @current_participant = current_participant
    # need a way of ducking out of attachments for unit tests
    if attachment.attachment_file_name != 'IGNORE_TEST'
      mail.attachments[attachment.attachment_file_name] = File.read("public/system/participant_attachments/#{attachment.id}/#{attachment.attachment_file_name}")
    end
    mail(from: Settings.mail.default_url_options.support_email, to: @participant.email, subject: t('mailer.participant.subject.shared_notification'), reply_to: @current_participant.email)
  end

  # Added to network
  def send_network_notification(network_participant, current_participant)
    @network_participant = network_participant
    @current_participant = current_participant
    mail(from: Settings.mail.default_url_options.support_email, to: network_participant.email, subject: t('mailer.participant.subject.added_in_network'), reply_to: @current_participant.email)
  end

  # Note shared
  def send_notification_to_participant(note_content, participant)
  	@participant = participant
  	@note_content = note_content
    replay_to  = "notify+#{@participant.id}@drivedb.net"
  	mail(from: Settings.mail.default_url_options.support_email, to: @participant.email, subject: t('mailer.participant.subject.note_notification'), reply_to: replay_to)
  end
end
