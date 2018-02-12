#3.Заполнить массив числами фибоначчи до 100

f_numbers = [0, 1]
index = 0
begin
  index += 1
  sum = f_numbers[index] + f_numbers[index-1]
  if sum < 100
    f_numbers.push(sum)
  end
end while sum < 100

puts "Fibonacci Numbers from 0 until 100: #{f_numbers}"

