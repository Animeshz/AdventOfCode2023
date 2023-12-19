line = gets.chomp
seqs = line.split(',')

ans = seqs.map { |seq| seq.chars.reduce(0) { |acc, e| (17 * (acc + e.ord)) % 256 } }.sum
puts ans
