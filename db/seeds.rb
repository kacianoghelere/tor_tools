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

default_skills = [
{
	name: "Agarra a Vítima", 
	cost: 0, 
	description: "se a principal forma de ataque 
 da criatura for bem-sucedida,
 a vítima não conseguirá mudar de posição e verá seu índice de Aparar
 reduzido pela metade (as frações são arredondas para cima); a criatura
 não terá como atacar com sua arma principal enquanto agarrar o alvo
 (mas poderá usar livremente um ataque secundário, caso tenha um)"},
{
	name: "Amendontar", 
	cost: 1, 
	description: "todos os companheiros são obrigados a fazer um teste de Medo
 (NA 14, salvo indicação em contrário)"},
{
	name: "Aversão à Luz do Sol", 
	cost: 0, 
	description: "quando expo1tsa à luz do sol, a criatura perde um ponto de Ódio
 no fim da primeira rodada de combate)"},
{
	name: "Couro Grosso", 
	cost: 0, 
	description: "Quando a criatura obtém um sucesso maior ou extraordinário num
 teste de Proteção, o atacante deixa cair sua arma (é possivel recuperar
 a arma usando-se uma ação inteira)"},
{
	name: "Desnortear", 
	cost: 1, 
	description: "O NA para acertar um companheiro nesta rodada não leva em
 considerção seu índice de Aparar (use apenas o NA da posição escolhida)"},
{
	name: "Detesta Algo", 
	cost: 0, 
	description: "Quando a criatura se ve diante de quem ou que detesta, todas
 as suas perícias com armas e formas de ataque são consideradas
 preferenciais"},
{
	name: "Encantamentos Terríveis", 
	cost: 1, 
	description: "Obrigue um companheiro a fazer um teste de Corrupção; se
 fracassar, ele receberá um ponto de Sombra e ficará sujeiro aos efeitos
 do encantamento específico da criatura"},
{
	name: "Encarnação do Horror", 
	cost: 0, 
	description: "Todos os heróis são obrigados a fazer um teste de Medo no
 começo de cada rodada até fracassar ou obter um sucesso maior ou
 extraordinário (NA 14, salvo indicação em contrário)"},
{
	name: "Força Aterradora", 
	cost: 1, 
	description: "Logo depois de um atauqe bem-sucedido, aumente a perda de
 Resistência do alvo em um número de pontos igual ao Nível de Atributo
 da criatura"},
{
	name: "Grande Salto", 
	cost: 1, 
	description: "A criatura pode atacar qualquer companheiro em qualquer posição
 de combate, inclusive a retaguarda"},
{
	name: "Grande Tamanho", 
	cost: 0, 
	description: "A criatura continuará lutando com Resistência zero ou quando
 Ferida uma vez, até ser Ferida uma segunda vez ou reduzida a Resistência
 zero e Ferida"},
{
	name: "Investida Selvagem", 
	cost: 1, 
	description: "Se a principal forma de ataque da criatura tiver obetido um
 sucesso maior ou extraordinário, ataque o mesmo alvo de novo usando a
 arma secundária da criatura"},
{
	name: "Medo do Fogo", 
	cost: 0, 
	description: "A criatura perderá  um ponto de Ódio no fim da primeira rodada
 de combate contra um adversário direto que empunhe uma tocha ou outro
 tipo de objeto em chamas"},
{
	name: "Natural da Escuridão",  
	cost: 0, 	
	description: "A criatura perderá um ponto de Ódio no fim da primeira rodade
 de combate contra um adversário direto que empunhe uma tocha ou outro
 tipo de objeto em chamas"},
{
	name: "Odor Nausebundo", 
	cost: 0, 
	description: "Os heróis que abordaram o monstro não conseguem realizar
 nenhuma outra ação fora atacar (nem as tarefas de combate)"},
{
	name: "Poltrão", 
	cost: 0, 
	description: "Se, no começo de uma rodada, a criatura se encontrar sem pontos
 de ódio, ela tentará fugir"},
{
	name: "Rapidez de uma Serpente", 
	cost: 1, 
	description: "Quando um herói fizer uma jogada para atacar a criatura,
 duplique o índice básico de Aparar do monstro (excluindo o bonus do
 escudo): se o índice agora for superior ao resultado da jogada, o ataque
 não acertá o alvo"},
{
	name: "Resiliência Terrível", 
	cost: 1, 
	description: "Diminua a perda de Resistência provocada pelo ataque de um
 inimigo em um número de pontos igual ao Nível de Atributo da criatura"},
{
	name: "Sem Trégua", 
	cost: 1,
	
	description: "Se nocautear um personage, a criatura poderá atacar de novo
 usando uma arma secundária: com um sucesso maior ou estraordinário, o
 alvo morrerá no mesmo instante"},
{
	name: "Velocidade Alucinante", 
	cost: 0, 
	description: "A criatura pode escolher quais heróis abordar no começo de cada
 turno (mesmo quando está em menor número), pode atacar heróis em qualquer
 posição e decidir abandonar o combate no começo de qualquer rodada"},
{
	name: "Voz Imperiosa", 
	cost: 1, 
	description: "Restaure um ponto de Ódio de todas as criaturas do mesmo tipo
 (sem incluir a criatura que usa esta habilidade especial)"}
]

User.first.skills.create!(default_skills)

10.times do |n|
	name         = Faker::Lorem.word.capitalize
	description  = Faker::Lorem.sentence
	user         = User.all.sample
	user.skills.create!(name: name, cost: 0, description: description)
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