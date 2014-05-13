class Participant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :scores
  paperclip_options = {
      styles: {
          medium: "#{Settings.paperclip.style.medium}>",
          thumb: "#{Settings.paperclip.style.thumb}>"
      },
      :url => Settings.paperclip.image_path
  }

  has_attached_file :photo, Paperclip::Attachment.default_options.merge(paperclip_options)
  validates_attachment_content_type :photo, content_type:  /\Aimage\/.*\Z/
  
  def full_name
    "#{first_name} #{last_name}"
  end

  def level_for(behaviour_id)
    score = scores.where(behaviour_id: behaviour_id, participant_id: id).first
    if (0..110).include?(score)
      1
    elsif (111..1999).include?(score)
      2
    elsif (2000..2999).include?(score)
      3
    elsif (3000..3999).include?(score)
      4
    elsif (4000..5000).include?(score)
      5
    else
      0
    end
  end
end
