#4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabet = "a".."z"

vowels = %w(a e i o u y)
vowels_hash = {}

alphabet.each_with_index {|v, i|
  vowels_hash[v] = i + 1 if vowels.include?(v)
}

puts "Vowels with position in alphabet: #{vowels_hash}"
