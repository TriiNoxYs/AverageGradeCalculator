require_relative "Matiere"
require_relative "Controle"
require_relative "Eleve"

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
	    coef = gets.chomp.to_f

	    matiere = Matiere.new(nom, coef)
	    puts "\nSubject created: #{matiere.nom} (x#{matiere.coef})"
	    $matieres << matiere

	    puts "\n--------------------"
	    modifier_matieres
	end

	def self.modifier_matiere(matiere)
		puts "\nEditing: #{matiere.nom} (x#{matiere.coef})"
	    print "New name: "
	    matiere.rename(gets.chomp)
	    print "New coefficient: "
	    matiere.change_coef(gets.chomp.to_i)
	    puts "\nEdit done: #{matiere.nom} (x#{matiere.coef})"
	    puts "\n--------------------"
	    modifier_matieres
	end

end


#--- INITIALISATION ---#
$matieres = []
main = Main.new

$matieres << Matiere.new("French", 			  4)
$matieres << Matiere.new("English", 		  2)
$matieres << Matiere.new("Spanish", 		  2)
$matieres << Matiere.new("Technology", 		  12)
$matieres << Matiere.new("Mathematics", 	  4)
$matieres << Matiere.new("Chemistry",	 	  4)
$matieres << Matiere.new("History/Geography", 2)
$matieres << Matiere.new("Sport", 			  2)


#--- START ---#
puts "Welcome to the AverageGradeCalculator, by TriiNoxYs.\n"
print "Please enter your name: "
$eleve = Eleve.new(gets.chomp)

Main.menu_principal