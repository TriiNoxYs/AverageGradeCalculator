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
		puts "Select subject from the list: "
		i = 0                                     #peut etre ajouter l'option 0 pour add/edit des matieres
	    $matieres.each do |matiere|
	    	i = i + 1
	      	puts "#{i} - #{matiere.nom}"
	    end
	    puts "99 - Quit"

	    print "Subject: "
	    matiere = $matieres[gets.chomp.to_i-1]

	    print "Your grade: "
	    note = gets.chomp.to_f

	    print "Coefficient: "
	    coef = gets.chomp.to_f

		controle = Controle.new(matiere, note, coef)
		puts "-> #{controle.matiere.nom} #{controle.note}/20 (x#{controle.coef})"
		@controles << controle

		Main.menu_principal
	end

	def demander_matiere_a_calculer
		puts "\nFor wich subject do you want to calculate the average grade ?"
		i = 0
	    $matieres.each do |matiere|
	    	i = i + 1
	      	puts "#{i} - #{matiere.nom}"
	    end
	    puts "99 - Quit"

	    print "Subject: "
	    matiere = $matieres[gets.chomp.to_i-1]

	    calculer_moyenne_matiere(matiere)
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

		#return moyenne_matiere
		puts "Average grade in #{matiere.nom}: #{moyenne_matiere}"
		Main.menu_principal
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


class Main

	def self.menu_principal
		puts "\nPlease #{$eleve.nom}, select what you want to do."
		puts "1 - Edit subjects"
		puts "2 - Add new grade"
		puts "3 - Calculate subject average grade"
		puts "4 - Calculate general average grade"
		puts "99 - Quit"
		print "Your choice: "
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
			puts "Bye !"
		else
			puts "Choice not valid."
			menu_principal
		end
	end

	def self.modifier_matieres
		if $matieres.empty?
			puts "There is no subject yet."
			puts "Would you add a new one? "
			puts "1 - Yes"
			puts "2 - No, quit"
			print "You choice: "
			choix = gets.chomp.to_i
		else
			puts "0 - Add new subject"
			i = 0
	    	$matieres.each do |matiere|
	    		i = i + 1
	      		puts "#{i} - Edit #{matiere.nom} (x#{matiere.coef})" #TODO: pouvoir supr une matiere
	    	end
	    	puts "99 - Quit"

	    	print "Your choice: "
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
		puts "\nCreating new subject."
	    print "Name: "
	    nom = gets.chomp
	    print "Coefficient: "
	    coef = gets.chomp.to_i

	    matiere = Matiere.new(nom, coef)
	    puts "\nSubject created: #{matiere.nom} (x#{matiere.coef})"
	    $matieres << matiere

	    puts "\n--------------------"
	    modifier_matieres
	end

	def self.modifier_matiere(matiere)
		puts "\nEditing: #{matiere.nom} (x#{matiere.coef})"
	    print "New name: "
	    matiere.nom = gets.chomp
	    print "New coefficient: "
	    matiere.coef = gets.chomp.to_i
	    puts "\nEdit done: #{matiere.nom} (x#{matiere.coef})"
	    puts "\n--------------------"
	    modifier_matieres
	end

end


#--- INITIALISATION ---#
$matieres = []
main = Main.new


francais = Matiere.new("Français", 2)
$matieres << francais


#--- START ---#
puts "Welcome to the AverageGradeCalculator, by TriiNoxYs.\n"
print "Please enter your name: "
$eleve = Eleve.new(gets.chomp)

Main.menu_principal