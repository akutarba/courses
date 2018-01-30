=begin
Прямоугольный треугольник. Программа запрашивает у пользователя 3 стороны треугольника и
определяет, является ли треугольник прямоугольным, используя теорему Пифагора (www-formula.ru) и
выводит результат на экран.

Также, если треугольник является при этом равнобедренным (т.е. у него равны любые 2 стороны),
то дополнительно выводится информация о том, что треугольник еще и равнобедренный.

Подсказка: чтобы воспользоваться
теоремой Пифагора, нужно сначала найти самую длинную сторону (гипотенуза) и сравнить ее значение в квадрате с суммой
квадратов двух остальных сторон.
 Если все 3 стороны равны, то треугольник равнобедренный и равносторонний, но не прямоугольный.
=end

puts "Welcome, let's check triangle! "

triangle_sides = []

triangle_sides = Array.new(3) do |i|
  print "Please enter #{i + 1} side of triangle? "
  gets.to_f
end

def check_rectangle_triangle(a)
  a[0] ** 2 + a[1] ** 2 == a[2] ** 2
end

def check_not_zero(sides)
  sides[0]*sides[1]*sides[2] != 0
end

triangle_sides.sort! #сортируем в возрастающем порядке

if triangle_sides[0] + triangle_sides[1] > triangle_sides[2] && check_not_zero(triangle_sides) #правило существования треугольника

  uniq_sides = triangle_sides.uniq #вычисляем количество уникальных сторон, 3 - обычный 2 = равнобедр, 1 - равносторонний

  case uniq_sides.length
  when 2
    if check_rectangle_triangle(triangle_sides)
      print "You have entered rectangular and isosceles triangle. "
    else
      print "You have entered isosceles triangle. "
    end
  when 3
    if check_rectangle_triangle(triangle_sides)
      print "You have entered rectangular triangle. "
    else
      print "You have entered simple triangle. "
    end
  when 1
    print "You have entered equilateral triangle. "
  else
    print "Triangle with provided sides doesn't exist! "
  end
else
  print "Triangle with provided sides doesn't exist! "
end


print "Sides of triangle: #{triangle_sides}"
