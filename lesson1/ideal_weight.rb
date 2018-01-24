# calculating ideal weight according hight


class IdealWeight
  def calc_ideal_weight(current_hight)
    if (current_hight - 110) > 0
      print "Your ideal weight is #{current_hight - 110}"
    else
      print "You are already perfect!"
    end
  end
end

print "Welcome to the program for calculating your ideal weight. \n"

print "What is your first name? "
first_name = gets.chomp.to_s.capitalize!

print "What is your last name? "
last_name = gets.chomp.to_s.capitalize!

print "Please enter your hight in 'sm': "
current_hight = gets.chomp.to_i

print "Hi #{first_name} #{last_name}. "

IdealWeight.new.calc_ideal_weight(current_hight)
