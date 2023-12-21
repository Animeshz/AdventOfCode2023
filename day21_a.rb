require 'set'

lines = []
while line=gets&.chomp
  lines << line
end

prev, curr = Set.new, Set.new
prev << lines.index { |line| /S/.match(line) }&.then { |i| [i, lines[i].index(/S/)] }

for i in 0...64
  for e in prev
    curr << [e[0]+1, e[1]] if lines[e[1]] != nil && lines[e[1]][e[0]+1] != '#'
    curr << [e[0]-1, e[1]] if lines[e[1]] != nil && lines[e[1]][e[0]-1] != '#'
    curr << [e[0], e[1]+1] if lines[e[1]+1] != nil && lines[e[1]+1][e[0]] != '#'
    curr << [e[0], e[1]-1] if lines[e[1]-1] != nil && lines[e[1]-1][e[0]] != '#'
  end
  prev, curr = curr, Set.new
end

puts prev.length
# puts prev.to_s
