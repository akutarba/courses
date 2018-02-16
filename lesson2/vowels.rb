#4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabet = "a".."z"

vowels = %w(a e i o u y)
vowels_hash = {}

alphabet.each.with_index(1) do  |vowel, index|
  vowels_hash[vowel] = index if vowels.include?(vowel)
end

puts "Vowels with position in alphabet: #{vowels_hash} "
