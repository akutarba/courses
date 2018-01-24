=begin
 Площадь треугольника. Площадь треугольника можно вычилсить, зная его
 основание (a) и высоту (h) по формуле: 1/2*a*h. Программа должна запрашивать
 основание и высоту треугольника и возвращать его площадь.
=end

class TriangleSquare
  def say_hi
    print "Welcome to the program for calculating triangle square. \n"
  end

  def calc_triangle_square(triangle_base_side, triangle_hight)
    if triangle_base_side > 0 && triangle_hight > 0
      print "Square of triangle is: #{0.5*triangle_base_side*triangle_hight}"
    else
      print "Triangle with entered side and hight doesn't exist."
    end
  end
end

TriangleSquare.new.say_hi


print "Please enter base side of triangle? "
triangl_base_side = gets.chomp.to_i

print "Please enter hight of triangle? "
triangle_hight = gets.chomp.to_i

TriangleSquare.new.calc_triangle_square(triangl_base_side,triangle_hight)

