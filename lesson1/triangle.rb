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

print "Welcome, let's check triangle! \n"

triangle_sides = []
for i in 1..3 do
  print "Please enter #{i} side of triangle? "
  triangle_sides[i - 1] = gets.chomp.to_i
end

triangle_sides.sort! #сортируем в возрастающем порядке

if triangle_sides[0] + triangle_sides[1] >= triangle_sides[2] #правило существования треугольника
  if triangle_sides[0] ** 2 + triangle_sides[1] ** 2 == triangle_sides[2] ** 2 #теорема пифагора
    if triangle_sides[0] == triangle_sides[1] # если прямоугольный, то может быть ранвтосторонним
      print "You have entered rectangular and isosceles triangle. "
    else
      print "You have entered rectangular triangle. " # или просто прямоугольный
    end
  elsif triangle_sides[0] == triangle_sides[1] || triangle_sides[1] == triangle_sides[2] # если не прямоугольный, то может быть равнобедренным
    if triangle_sides[0] == triangle_sides[2] # или равносторонним
      print "You have entered equilateral triangle. "
    else
      print "You have entered isosceles triangle. "
    end
  else
    print "You have entered simple triangle. "
  end
else
  print "Triangle with provided sides doesn't exist! "
end

print "Sides of triangle: #{triangle_sides}"
