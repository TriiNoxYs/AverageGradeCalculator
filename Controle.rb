class Controle
	attr_reader :matiere, :note, :coef

	def initialize(matiere, note, coef)
		@matiere = matiere
		@note = note
		@coef = coef
	end
end