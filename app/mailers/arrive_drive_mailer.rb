class ArriveDriveMailer < ActionMailer::Base
  def send_participant_invitation(participant)
    mail(from: 'arriva@drive.com', to: participant.email, subject: 'Welcom')
  end
end
