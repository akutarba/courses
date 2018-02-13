=begin
5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). Найти порядковый номер даты, начиная отсчет с начала года.
Учесть, что год может быть високосным. (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?)
Алгоритм опредления високосного года: www.adm.yar.ru
=end

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Welcome, let's check number of the date: "

puts "Please enter the date DD/MM/YYYY:"
day, month, year = gets.split('/')

day = day.to_i
month = month.to_i
year = year.to_i

if month == 1
  puts "Number of date is #{day}"
elsif year % 4 == 0 && (year % 100 != 0|| year % 400 == 0)
  puts "Number of date is #{months.take(month - 1).inject(:+) + day + 1} (leap year)."
else
  puts "Number of date is #{months.take(month - 1).inject(:+) + day}."
end
