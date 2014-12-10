class EventFile < ActiveRecord::Base

	belongs_to :event
	has_attached_file :event_doc, Paperclip::Attachment.default_options.merge(Settings.event_attachments.paperclip)
	do_not_validate_attachment_file_type :event_doc
	validates_attachment_size :event_doc, :less_than => 20.megabytes

end
