=begin
5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). Найти порядковый номер даты, начиная отсчет с начала года.
Учесть, что год может быть високосным. (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?)
Алгоритм опредления високосного года: www.adm.yar.ru
=end

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Welcome, let's check number of the date: "

puts "Please enter the date DD/MM/YYYY:"
day, month, year = gets.chomp.split('/').map(&:to_i) #спасибо за подсказку, не разобралась как это лучше сделать сразу при вводе

if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
  months[1] = 29
end

puts "Number of date is #{months.take(month - 1).inject(0,:+) + day} "




