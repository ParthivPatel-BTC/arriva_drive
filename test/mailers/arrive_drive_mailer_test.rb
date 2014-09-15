require 'test_helper'
require 'pp'
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
    mail = ArriveDriveMailer.send_shared_notification(@attachment, @paul, @bob)
    assert_equal "DRIVE: New Shared File", mail.subject
    #show_me_the_email(mail)
  end
  
  test "Test note notifications look good" do 
    @note = Note.create(owner: @bob, content: "Hello there. This is my note.")
    mail = ArriveDriveMailer.send_notification_to_participant(@note, @paul, @bob)
    assert_equal "DRIVE: New Shared Note", mail.subject
    #show_me_the_email(mail)
  end

  test "Test can extract nice  bits of email" do
    email_body = File.open("#{Rails.root}/test/fixtures/sample_email_2.txt",'r').read
    mail = Mail.new(email_body)
    reply = EmailReplyParser.read(mail.body.raw_source)
    pp reply.fragments[0]
    content = reply.fragments[0].to_s
    content = content.gsub(/^--(_|[0-9])+.+\n/,'').gsub(/^Content-.+\:.+\n/,'')
    puts content
    assert_equal("THANK THE LORD",content)
  end
  
  def show_me_the_email(mail)     
      File.delete('/tmp/mail.html')
      File.open('/tmp/mail.html','w').write mail.body
      `open /tmp/mail.html`      
  end
end
