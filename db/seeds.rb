10.times do
    character_name = Faker::Name.name
  
    Character.create! name: character_name,
                 health: 100 + Random.rand(49999),
                 attack: 100 + Random.rand(999),
                 speed: Random.rand(10),
                 dodge_rate: Random.rand(10),
                 critical_rate: Random.rand(10)
  end