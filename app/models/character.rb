class Character < ActiveRecord::Base
  validates_with CharacterValidator

  before_save :calculate_power_and_rank
  
  has_many :wins, class_name: "Clash", foreign_key: "winner_id"
  has_many :losses, class_name: "Clash", foreign_key: "loser_id"

  has_attached_file :avatar,
                    :styles => {:profile => "512x512#"},
                    :url => "/system/:class/:attachment/:id/:style/:updated_at/:hash.:extension",
                    :default_url => "/images/character/missing_:style.jpg",
                    :hash_secret => Rails.application.secrets.secret_key_base,
                    :preserve_firl => "true"

                    validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png'], :message => "L'avatar doit être un png ou un jpeg"
                    validates_attachment_file_name :avatar, :matches => [/png\Z/i, /jpe?g\Z/i], :message => "L'avatar doit être un png ou un jpeg"
  end

  
  def to_param
    "#{id}-#{name.parameterize}"
  end

  def to_hash
    {name: self.name, health: self.health, attack: self.attack, speed: self.speed, dodge_rate: self.dodge_rate, critical_rate: self.critical_rate}
  end

  private

  def attack_against(enemy_character)
    damage, attack_type = determine_damage
    health, defend_type = enemy_character.determine_defense(damage)

    ClashEvent.create(attacker_name: self.name,
                      attack_type: attack_type,
                      attack_damage: damage,
                      defender_name: enemy_character.name,
                      defend_type: defend_type,
                      defender_health: health)
  end

  def determine_damage
    if Random.rand(100) < self.critical_rate
      [self.attack * 2, ClashEvent.attack_types['critical']]
    else
      [self.attack, ClashEvent.attack_types['normal']]
    end
  end

  def determine_defense(damage)
    if Random.rand(100) < self.dodge_rate
      [self.health, ClashEvent.defend_types['dodge']]
    else
      self.health = damage < self.health ? self.health - damage : 0
      [self.health, ClashEvent.defend_types['receive']]
    end
  end
  
  def calculate_power_and_rank
    self.power = self.health + self.attack
    self.power += self.health * (self.dodge_rate / 100.0)
    self.power += self.attack * (self.critical_rate / 100.0)
    
    self.rank = self.power.to_i.to_s.length
  end
  