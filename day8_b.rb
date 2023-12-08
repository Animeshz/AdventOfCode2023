map_matcher = /(\w+) = \((\w+), (\w+)\)/
instructions = gets.chomp

map = {}
currents = []
while line=gets
  move = map_matcher.match(line)&.captures
  if !move then next end

  map[move[0]] = [move[1], move[2]]
  currents << move[0] if move[0][-1] == 'A'
end

dp = Hash.new { |hash, c|
  hash[c] = Hash.new { |subhash, i|
    subhash[i] = map[c][instructions[i%instructions.length] == 'R' ? 1 : 0]
  }
}
currents.map! do |c|
  (0..).find { |i| break i+1 if (c = dp[c][i])[-1] == 'Z' }
end

puts currents.reduce { |a, b| a.lcm b }.to_s
