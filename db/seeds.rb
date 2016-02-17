User.create!(name:	"Kaciano Ghelere",
						 email: "kaciano_ghelere@yahoo.com.br",
						 password:							"123456",
						 password_confirmation: "123456",
						 admin: true)

9.times do |n|
	name	   = Faker::Name.name
	email    = "example-#{n+1}@railstutorial.org"
	password = "password"
	User.create!(name:	name, email: email, password: password,
							 password_confirmation: password)
end

encs = ["Desarma", "Perfura", "Destrói Escudo"]
15.times do |n|
	name   = Faker::Lorem.word.capitalize
	damage = rand(1..10)
	edge   = rand(0..11)
	injury = rand(1..20)
	enc    = encs.sample
	user   = User.all.sample
	Weapon.create!(name: name, damage: damage, edge: edge, injury: injury, 
									enc: enc, user: user)
end

10.times do |n|
	name         = Faker::Lorem.word.capitalize
	description  = Faker::Lorem.sentence
	user         = User.all.sample
	Skill.create!(name: name, description: description, user: user)
end

20.times do |n|
	name        = Faker::Lorem.word.capitalize
	description = Faker::Lorem.sentence
	img_url     = Faker::Avatar.image
	ally        = [true, false].sample
	attr_index  = rand(1..12)
	resistance  = (attr_index * 6)
	resource    = rand(2..5)
	parry       = rand(2..5)
	armour      = rand(1..6)
	personality = rand(1..3)
	movement    = rand(1..3)
	perception  = rand(1..3)
	survival    = rand(1..3)
	custom      = rand(1..3)
	vocation    = rand(1..3)
	user        = User.all.sample
	npc = Npc.create!(name: name, description: description, img_url: img_url, 
					ally: ally, attr_index: attr_index, resistance: resistance, 
					resource: resource, parry: parry, armour: armour, 
					personality: personality, movement: movement, 
					perception: perception, survival: survival, custom: custom, 
					vocation: vocation, user: user)

	weapons = rand(1..3)
	weapons.times do |n|
		weapon = Weapon.all.sample
		bonus  = rand(1..3)
		NpcWeapon.create!(npc: npc, weapon: weapon, bonus: bonus)
	end

	skills = rand(1..3)
	skills.times do |n|
		skill = Skill.all.sample
		NpcSkill.create!(npc: npc, skill: skill)
	end
end

5.times do |n|
	user   = User.all.sample
	amount = rand(1..6)
	npc    = Npc.all.sample
	title  = npc.name.pluralize
	party  = Party.create!(title: title, user: user)
	PartyNpc.create!(party: party, npc: npc, amount: amount)
end