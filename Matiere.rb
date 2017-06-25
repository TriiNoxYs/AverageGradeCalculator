class Matiere
	attr_reader :nom, :coef

	def initialize(nom, coef)
		@nom = nom
		@coef = coef
	end


	def rename(nom)
		@nom = nom
	end

	def change_coef(coef)
		@coef = coef		
	end

end