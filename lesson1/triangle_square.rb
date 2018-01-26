=begin
 Площадь треугольника. Площадь треугольника можно вычилсить, зная его
 основание (a) и высоту (h) по формуле: 1/2*a*h. Программа должна запрашивать
 основание и высоту треугольника и возвращать его площадь.
=end


print "Welcome to the program for calculating triangle square. \n"

print "Please enter base side of triangle? "
triangle_base_side = gets.chomp.to_i

print "Please enter hight of triangle? "
triangle_hight = gets.chomp.to_i

if triangle_base_side > 0 && triangle_hight > 0
  print "Square of triangle is: #{0.5*triangle_base_side*triangle_hight}"
else
  print "Triangle with entered side and hight doesn't exist."
end
