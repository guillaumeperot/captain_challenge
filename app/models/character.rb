class Character < ActiveRecord::Base
  validates_with CharacterValidator

  has_attached_file :avatar,
                    :styles => {:profile => "512x512#"},
                    :url => "/system/:class/:attachment/:id/:style/:updated_at/:hash.:extension",
                    :default_url => "/images/character/missing_:style.jpg",
                    :hash_secret => Rails.application.secrets.secret_key_base,
                    :preserve_firl => "true"

                    validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png'], :message => "L'avatar doit être un png ou un jpeg"
                    validates_attachment_file_name :avatar, :matches => [/png\Z/i, /jpe?g\Z/i], :message => "L'avatar doit être un png ou un jpeg"
  end

  before_save :calculate_power_and_rank

  def compute_power_and_rank
    self.power = self.health + self.attack
    self.power += self.health * (self.dodge_rate / 100.0)
    self.power += self.attack * (self.critical_rate / 100.0)

    self.rank = self.power.to_i.to_s.length
  end


  def to_param
    "#{id}-#{name.parameterize}"
  end