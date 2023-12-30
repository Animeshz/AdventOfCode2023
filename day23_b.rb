require 'set'

grid = []
while line=gets&.chomp
  grid << line.chars
end

startx = grid[0].index { |c| c != '#' }

# 2d grid -> graph(v, e)
nodes = Set.new grid.each_with_index.map { |row, y| row.each_with_index.filter_map { |c, x| c != '#' ? [x, y] : nil } }.flatten(1)
edges = Hash.new { |h, k| h[k] = {} }
nodes.each do |n|
  x, y = n
  for dx, dy in [[1, 0], [-1, 0], [0, 1], [0, -1]]
    nx, ny = x+dx, y+dy
    if nodes.include?([nx, ny])
      edges[n][[nx, ny]] = 1
    end
  end
end
# puts nodes.to_s
# puts edges.to_s

# compress graph
for n, tos in edges
  if tos.length == 2 then  # merge all non-joints
    l, r = tos.keys
    edges[l][r] = tos[l]+tos[r]
    edges[r][l] = tos[l]+tos[r]

    edges.delete(n)
    edges[l].delete(n)
    edges[r].delete(n)
  end
end
# pp edges
# puts edges.keys.length
puts edges.values.map(&:size).map{ |v| v>1 ? v-1 : 1 }.reduce(&:*) # total path combinations

q = [[startx, 0, 0, []]]
ans = 0
while !q.empty? do
  x, y, len, seen = q.pop
  ans = [ans, len].max if y == grid.length-1
  puts ans

  edges[[x, y]].each { |to, d| q << [to[0], to[1], len+d, seen+[to]] if !seen.include?(to) }
end

puts ans
