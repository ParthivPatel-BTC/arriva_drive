require 'test_helper'

class ArriveDriveMailerTest < ActionMailer::TestCase
  def setup
    @bob = Participant.create(first_name: "Bob", last_name: "Smith", email: "bs@pocketworks.co.uk")
    @paul = Participant.create(first_name: "Paul", last_name: "Roberts", email: "pr@pocketworks.co.uk")    
  end
  
  test "Test network notificaiton email looks good" do
    mail = ArriveDriveMailer.send_network_notification(@paul, @bob)
    assert_equal "DRIVE: Welcome To My Network", mail.subject
    #show_me_the_email(mail)
  end
  
  test "Attachment notifications look good" do
    @attachment = OpenStruct.new({id: '1',attachment_file_name: 'IGNORE_TEST'})
    mail = ArriveDriveMailer.send_shared_notification(@attachment, @paul, @bob.email)
    assert_equal "DRIVE: New Shared File", mail.subject
    #show_me_the_email(mail)
  end
  
  test "Test note notifications look good" do 
    @note = Note.create(owner: @bob, content: "Hello there. This is my note.")
    mail = ArriveDriveMailer.send_notification_to_participant(@note, @paul)
    assert_equal "DRIVE: New Shared Note", mail.subject
    #show_me_the_email(mail)
  end
  
  def show_me_the_email(mail)     
      File.delete('/tmp/mail.html')
      File.open('/tmp/mail.html','w').write mail.body
      `open /tmp/mail.html`      
  end
end
