#2. Заполнить массив числами от 10 до 100 с шагом 5

i = 10
numbers =[]
while i <= 100
  numbers.push(i)
  i += 5
end

puts "Numbers from #{numbers.first} until #{numbers.last} with step 5: #{numbers}"