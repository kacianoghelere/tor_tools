User.create!(name:	"Kaciano Ghelere",
						 email: "kaciano_ghelere@yahoo.com.br",
						 password:              "123456",
						 password_confirmation: "123456",
						 admin: true)

10.times do |n|
	name	   = Faker::Name.name
	email    = "example-#{n+1}@railstutorial.org"
	password = "password"
	User.create!(name:	name, email: email, password: password,
							 password_confirmation: password)
end

# Following relationships
users = User.all
user  = users.first
following = users[2..10]
followers = users[3..8]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

WeaponCategory.create!(name: "Espada", effect: "Desarma")
WeaponCategory.create!(name: "Machado", effect: "Destrói Escudo")
WeaponCategory.create!(name: "Arco", effect: "Perfura")
WeaponCategory.create!(name: "Lança", effect: "Perfura")
WeaponCategory.create!(name: "Punhal", effect: "")

15.times do |n|
	name     = Faker::Lorem.word.capitalize
	damage   = rand(1..10)
	edge     = rand(0..11)
	injury   = rand(1..20)
	user     = User.all.sample
	category = WeaponCategory.all.sample
	user.weapons.create!(name: "#{category.name} #{name}", damage: damage, 
									edge: edge, injury: injury, weapon_category: category)
end

10.times do |n|
	name         = Faker::Lorem.word.capitalize
	description  = Faker::Lorem.sentence
	user         = User.all.sample
	user.skills.create!(name: name, description: description)
end

20.times do |n|
	name        = Faker::Norse.name.capitalize
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
	npc = user.npcs.create!(name: name, description: description, img_url: img_url, 
					ally: ally, attr_index: attr_index, resistance: resistance, 
					resource: resource, parry: parry, armour: armour, 
					personality: personality, movement: movement, 
					perception: perception, survival: survival, custom: custom, 
					vocation: vocation)

	weapons = rand(1..3)
	weapons.times do |n|
		npc.equipments.create!(npc: npc, weapon: Weapon.all.sample, bonus: rand(1..3))
	end

	skills = rand(1..3)
	skills.times do |n|
		npc.npc_skills.create!(npc: npc, skill: Skill.all.sample)
	end
end

5.times do |n|
	user   = User.all.sample
	amount = rand(1..4)
	title  = Faker::Lorem.word.capitalize
	party  = user.parties.create!(title: title)
	amount.times do |x|
		npc = Npc.all.sample
		party.members.create!(npc: npc, amount: rand(1..4))
	end
end