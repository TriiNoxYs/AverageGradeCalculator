class Matiere
	attr_accessor :nom, :coef

	def initialize(nom, coef)
		@nom = nom
		@coef = coef
	end
end


class Controle
	attr_accessor :matiere, :note, :coef

	def initialize(matiere, note, coef)
		@matiere = matiere
		@note = note
		@coef = coef
	end
end


class Eleve
	attr_accessor :nom, :controles, :moyennes, :moyenne_generale

	def initialize(nom)
		@nom = nom
		@controles = []
		@moyennes = {}
		@moyenne_generale = 0.0
	end

	def calculer_moyenne_matiere(matiere)
		addition_notes = 0.0
		addition_coefs = 0.0
		moyenne_matiere = 0.0

		@controles.each do |controle|
			addition_notes += controle.note * controle.coef
			addition_coefs += controle.coef
		end

		moyenne_matiere += addition_notes / addition_coefs #peut etre supr et passé direct en arg
		@moyennes[:matiere] = moyenne_matiere

		return moyenne_matiere
	end

	def calculer_moyenne_generale
		addition_moyennes = 0.0
		addition_coefs_moyennes = 0

		@moyennes.each do |matiere, moyenne|
			addition_moyennes += moyenne * matiere.coef
			addition_coefs_moyennes += matiere.coef
		end

		@moyenne_generale = addition_moyennes / addition_coefs_moyennes

		return @moyenne_generale #pas utile car derniere variable retournée
	end

end