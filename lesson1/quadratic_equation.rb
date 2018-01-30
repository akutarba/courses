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

equiation_koef = []

a, b, c = Array.new(3) do |i|
  print "Please enter #{i} koefficient"
  gets.to_i
end

for i in 1..3 do
  print "Please enter #{i} koefficient? "
  equiation_koef[i - 1] = gets.chomp.to_i
end

def diskriminant(k)
  k[1] ** 2 - 4 * k[0] * k[2]
end

def calculate_roots (k, d)

  if d > 0
    sqrt_d =  Math.sqrt(d)
    root1 = -k[1] + sqrt_d / (2 * k[0])
    root2 = -k[1] - sqrt_d / (2 * kf[0])
    [root1.to_i, root2.to_i]
  else
    root = -k[1]/ 2 * k[0]
    [root.to_i]
  end

end

discr = diskriminant(equiation_koef).to_i

if discr > 0
  print "Diskriminant of quadratic equation: #{discr}. Roots: #{count_roots(equiation_koef, discr)}"
elsif discr == 0
  print "Diskriminant of quadratic equation: #{discr}. Root: #{count_roots(equiation_koef, discr)}"
else
  print "Diskriminant of quadratic equation: #{discr}. Equation have no roots."
end



