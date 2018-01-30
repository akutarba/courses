# calculating ideal weight according hight

puts "Welcome to the program for calculating your ideal weight. "

print "What is your first name? "
first_name = gets.chomp.capitalize

print "What is your last name? "
last_name = gets.chomp.capitalize

print "Please enter your hight in 'sm': "
current_hight = gets.chomp.to_i

print "Hi #{first_name} #{last_name}. "

ideal_weight = current_hight - 110

if ideal_weight > 0
  print "Your ideal weight is #{ideal_weight}"
else
  print "You are already perfect!"
end


