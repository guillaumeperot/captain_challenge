class CharacterValidator < ActiveModel::Validator
    def validate(character)
      validates_presence_of_attributes(character)
  
      unless character.errors.any?
        validates_range_of_attributes(character)
      end
    end
  
    private
  
      def validates_presence_of_attributes(character)
        character.errors[:name] << "cannot be blank" if character.name.blank?
        character.errors[:health] << "cannot be blank" if character.health.blank?
        character.errors[:attack] << "cannot be blank" if character.attack.blank?
        character.errors[:speed] << "cannot be blank" if character.speed.blank?
        character.errors[:dodge_rate] << "cannot be blank" if character.dodge_rate.blank?
        character.errors[:critical_rate] << "cannot be blank" if character.critical_rate.blank?
      end
  
      def validates_range_of_attributes(character)
        character.errors[:health] << "cannot be negative" if character.health < 0
        character.errors[:attack] << "cannot be negative" if character.attack < 0
        character.errors[:speed] << "cannot be negative" if character.speed < 0
        character.errors[:dodge_rate] << "must be between 0 and 100" if character.dodge_rate < 0 || character.dodge_rate > 100
        character.errors[:critical_rate] << "must be between 0 and 100" if character.critical_rate < 0 || character.critical_rate > 100
      end
  end 