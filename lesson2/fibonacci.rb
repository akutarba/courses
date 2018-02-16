#3.Заполнить массив числами фибоначчи до 100

f_numbers = [0, 1]
sum = 0

while (sum =  f_numbers[-1] + f_numbers[-2]) < 100
  f_numbers << sum
end

puts "Fibonacci Numbers from 0 until 100: #{f_numbers} "
