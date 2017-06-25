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


class Main

	def self.menu_principal
		puts "\nQue voulez-vous faire, #{$eleve.nom}?"
		puts "1 - Modifier les matières"
		puts "2 - Ajouter une note"
		puts "3 - Calculer la moyenne dans une matière"
		puts "4 - Calculer la moyenne générale"
		puts "99 - Quitter"
		print "Votre choix: "
		choix = gets.chomp.to_i

		if choix == 1
			Main.modifier_matieres
		elsif choix == 2
			$eleve.ajouter_controle
		elsif choix == 3
			$eleve.demander_matiere_a_calculer
		elsif choix == 4
			$eleve.calculer_moyenne_generale
		elsif choix == 99
			puts "A bientôt !"
		else
			puts "Choix invalide.."
			menu_principal
		end
	end

	def self.modifier_matieres
		if $matieres.empty?
			puts "Il n'y a aucune matière."
			puts "Voulez-vous en ajouter une? "
			puts "1 - Oui"
			puts "2 - Non (retour)"
			print "Votre choix: "
			choix = gets.chomp.to_i
		else
			puts "0 - Ajouter une nouvelle matière"
			i = 0
	    	$matieres.each do |matiere|
	    		i = i + 1
	      		puts "#{i} - Modifier #{matiere.nom} (x#{matiere.coef})" #TODO: pouvoir supr une matiere
	    	end
	    	puts "99 - Retour"

	    	print "Votre choix: "
	    	choix = gets.chomp.to_i

	    	if choix == 0
	    		creer_matiere
	    	elsif choix != 99
	    		matiere = $matieres[choix-1]
	    		modifier_matiere(matiere)
	    	else
	    		menu_principal
	    	end
	    end
	end

	def self.creer_matiere
		puts "\nCreation d'une nouvelle matière."
	    print "Nom: "
	    nom = gets.chomp
	    print "Coefficient: "
	    coef = gets.chomp.to_f

	    matiere = Matiere.new(nom, coef)
	    puts "\nNouvelle matière créée: #{matiere.nom} (x#{matiere.coef})"
	    $matieres << matiere

	    puts "\n--------------------"
	    modifier_matieres
	end

	def self.modifier_matiere(matiere)
		puts "\nModification de #{matiere.nom} (x#{matiere.coef})"
	    print "NNouveau nom: "
	    matiere.nom = gets.chomp
	    print "Nouveau coefficient: "
	    matiere.coef = gets.chomp.to_i
	    puts "\nModification terminée: #{matiere.nom} (x#{matiere.coef})"
	    puts "\n--------------------"
	    modifier_matieres
	end

end


#--- INITIALISATION ---#
$matieres = []
main = Main.new

$matieres << Matiere.new("Français", 			4)
$matieres << Matiere.new("Anglais", 		    2)
$matieres << Matiere.new("Espagnol", 		    2)
$matieres << Matiere.new("Technologie",      	12)
$matieres << Matiere.new("Mathématiques", 	    4)
$matieres << Matiere.new("Physique-Chimie",	    4)
$matieres << Matiere.new("Histoire-Geographie", 2)
$matieres << Matiere.new("Sport", 			    2)


#--- START ---#
puts "Bienvenue dans le calculateur de moyenne, créé par TriiNoxYs.\n"
print "Merci de renseigner votre nom: "
$eleve = Eleve.new(gets.chomp)

Main.menu_principal