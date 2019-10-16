class Clash < ActiveRecord::Base
    private_class_method :new, :create
    serialize [:winner_attributes, :loser_attributes]
  
    belongs_to :winner, class_name: "Character", foreign_key: "winner_id"
    belongs_to :loser, class_name: "Character", foreign_key: "loser_id"
  
    has_many :clash_events

    def self.clash_between(character_one, character_two)
        clash = new
        winner, loser = clash.generate_clash_events(character_one, character_two)
    
        clash.winner = winner
        clash.loser = loser
        clash.winner_attributes = winner.to_hash
        clash.loser_attributes = loser.to_hash
        clash.save
    
        clash
    end
    
    def generate_clash_events(character_one, character_two)
        first_character, second_character = detect_order_of_attacks(character_one, character_two)
    
        while first_character.health > 0 && second_character.health > 0 do
            self.clash_events << first_character.attack_against(second_character)
            self.clash_events << second_character.attack_against(first_character) unless second_character.health == 0
        end
    
        detect_winner_and_loser(first_character, second_character)
    end
    
    private
    
    def detect_order_of_attacks(character_one, character_two)
        if character_one.speed >= character_two.speed
            [character_one, character_two]
        else
            [character_two, character_one]
        end
    end
    
    def detect_winner_and_loser(first_character, second_character)
        if first_character.health > 0
            [first_character, second_character]
        else
            [second_character, first_character]
        end
    end
end