map_matcher = /(\w+) = \((\w+), (\w+)\)/
instructions = gets.chomp

map = {}
while line=gets
  move = map_matcher.match(line)&.captures
  if !move then next end

  map[move[0]] = [move[1], move[2]]
end

current = "AAA"
i = 0
while current != "ZZZ" do
  current = map[current][instructions[i%instructions.length] == 'R' ? 1 : 0]
  i += 1
end

puts i
