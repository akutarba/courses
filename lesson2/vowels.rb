#4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabet = ("a".."z").to_a

vowels = ["a", "e", "i", "o", "u", "y"]
vowels_hash = {}

alphabet.each_index {|index| vowels_hash[alphabet[index]] = index + 1 if vowels.include?(alphabet[index])}

puts "Vowels with position in alphabet: #{vowels_hash}"
