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

sides = Array.new(3) do |i|
  print "Please enter #{i + 1} side of triangle? "
  gets.to_f
end

def rectangle_triangle?(sides)
  sides[0] ** 2 + sides[1] ** 2 == sides[2] ** 2
end


sides.sort! #сортируем в возрастающем порядке

if sides[0] + sides[1] > sides[2] && sides.none?(&:zero?) #правило существования треугольника

  uniq_sides = sides.uniq #вычисляем количество уникальных сторон, 3 - обычный 2 = равнобедр, 1 - равносторонний

  case uniq_sides.length
  when 1
    print "You have entered equilateral triangle. "
  when 2
    if rectangle_triangle?(sides)
      print "You have entered rectangular and isosceles triangle. "
    else
      print "You have entered isosceles triangle. "
    end
  when 3
    if rectangle_triangle?(sides)
      print "You have entered rectangular triangle. "
    else
      print "You have entered simple triangle. "
    end
  else
    print "Triangle with provided sides doesn't exist! "
  end
else
  print "Triangle with provided sides doesn't exist! "
end


print "Sides of triangle: #{sides}"
