=begin
6. Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом).
Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара.

На основе введенных данных требуетеся:
Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш,
 содержащий цену за единицу товара и кол-во купленного товара.

Также вывести итоговую сумму за каждый товар.
Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
=end

products = {}

loop do
  puts "Please enter the product name: "
  name = gets.chomp.capitalize
  break if name == "Stop"
  puts "Please enter the price of the ""#{name}"":"
  price = gets.to_f
  puts "and the quantity of ""#{name}"":"
  quantity = gets.to_f
  products[name] = {price => quantity}
end
puts "In your shopping cart: #{products}"

purchase_amount = 0

products.each do |name, data|
  data.each do |price, quantity|
    sum = price * quantity
    purchase_amount += sum
    puts "Price of #{name} is: #{sum}"
  end
end
puts "You have spent: #{purchase_amount}"