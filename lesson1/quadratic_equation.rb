=begin
Квадратное уравнение. Пользователь вводит 3 коэффициента a, b и с.
Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если они есть)
и выводит значения дискриминанта и корней на экран. При этом возможны следующие варианты:
  Если D > 0, то выводим дискриминант и 2 корня
  Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
  Если D < 0, то выводим дискриминант и сообщение "Корней нет"

Подсказка: Алгоритм решения с блок-схемой (www.bolshoyvopros.ru). Для вычисления квадратного корня, нужно использовать

Для теста:
Задача. Сколько корней имеют квадратные уравнения:
x2 − 8x + 12 = 0;
5x2 + 3x + 7 = 0;
x2 − 6x + 9 = 0.
Выпишем коэффициенты для первого уравнения и найдем дискриминант:
a = 1, b = −8, c = 12;
D = (−8)2 − 4 · 1 · 12 = 64 − 48 = 16 Итак, дискриминант положительный, поэтому уравнение имеет два различных корня. Аналогично разбираем второе уравнение:
a = 5; b = 3; c = 7;
D = 32 − 4 · 5 · 7 = 9 − 140 = −131. Дискриминант отрицательный, корней нет. Осталось последнее уравнение:
a = 1; b = −6; c = 9;
D = (−6)2 − 4 · 1 · 9 = 36 − 36 = 0. Дискриминант равен нулю — корень будет один.
=end

puts "Welcome, let's count diskriminant and roots of quadratic equation!. "

a, b, c = Array.new(3) do |i|
  print "Please enter #{i + 1} koefficient: "
  gets.to_f
end

def diskriminant(a, b, c)
  b ** 2 - 4 * a * c
end

discr = diskriminant(a, b, c)

if a != 0
  sqrt_d = Math.sqrt(discr)
  if  discr == 0
    print "Diskriminant of quadratic equation: #{discr}. Root: #{-b / (2 * a)}"
  elsif discr > 0
    print "Diskriminant of quadratic equation: #{discr}. Roots: #{[(-b + sqrt_d) / (2 * a), (-b - sqrt_d) / (2 * a)]}"
  else
    print "Diskriminant of quadratic equation: #{discr}. Equation have no roots."
  end
else
  print "Quadratic equation with #{[a, b, c]} doesn't exist!"
end

