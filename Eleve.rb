class Eleve
	attr_reader :nom, :controles, :moyennes, :moyenne_generale

	def initialize(nom)
		@nom = nom
		@controles = []
		@moyennes = {}
		@moyenne_generale = 0.0
	end

	def ajouter_controle
		puts "Selectionnez la matière: "
		i = 0                                     #peut etre ajouter l'option 0 pour add/edit des matieres
	    $matieres.each do |matiere|
	    	i = i + 1
	      	puts "#{i} - #{matiere.nom}"
	    end
	    puts "99 - Retour"

	    print "Matière: "
	    matiere = $matieres[gets.chomp.to_i-1]

	    print "Note: "
	    note = gets.chomp.to_f

	    print "Coefficient: "
	    coef = gets.chomp.to_f

		controle = Controle.new(matiere, note, coef)
		puts "-> #{controle.matiere.nom} #{controle.note}/20 (x#{controle.coef})"
		@controles << controle

		Main.menu_principal
	end

	def demander_matiere_a_calculer
		puts "\nPour quelle matière voulez-vous calculer la moyenne ?"
		i = 0
	    $matieres.each do |matiere|
	    	i = i + 1
	      	puts "#{i} - #{matiere.nom}"
	    end
	    puts "99 - Retour"

	    print "Matière: "
	    matiere = $matieres[gets.chomp.to_i-1]

	    calculer_moyenne_matiere(matiere)
	end

	def calculer_moyenne_matiere(matiere)
		addition_notes = 0.0
		addition_coefs = 0.0
		moyenne_matiere = 0.0

		@controles.each do |controle|
			if controle.matiere == matiere
				addition_notes += controle.note * controle.coef
				addition_coefs += controle.coef
			end
		end

		moyenne_matiere += addition_notes / addition_coefs #peut etre supr et passé direct en arg
		@moyennes[matiere] = moyenne_matiere

		#return moyenne_matiere
		puts "Moyenne en #{matiere.nom}: #{moyenne_matiere}"
		Main.menu_principal
	end

	def calculer_moyenne_generale
		addition_moyennes = 0.0
		addition_coefs_moyennes = 0.0

		@moyennes.each do |matiere, moyenne|
			addition_moyennes += moyenne * matiere.coef
			addition_coefs_moyennes += matiere.coef
		end

		@moyenne_generale = addition_moyennes / addition_coefs_moyennes

		puts "Moyenne générale: #{@moyenne_generale}"
		Main.menu_principal
	end

end