grid = []
while line=gets&.chomp
  grid << line.chars
end

# north west south east
def transform(grid)
  grid
    .transpose.map { |row| row.chunk { |cell| cell == '#' }.flat_map { |is_obstacle, cells| is_obstacle ? cells : cells.sort.reverse } }.transpose
    .map { |row| row.chunk { |cell| cell == '#' }.flat_map { |is_obstacle, cells| is_obstacle ? cells : cells.sort.reverse } }
    .transpose.map { |row| row.chunk { |cell| cell == '#' }.flat_map { |is_obstacle, cells| is_obstacle ? cells : cells.sort } }.transpose
    .map { |row| row.reverse.chunk { |cell| cell == '#' }.flat_map { |is_obstacle, cells| is_obstacle ? cells : cells.sort.reverse }.reverse }
end

hm = {}
for i in 0...1000000000
  grid = transform(grid)

  if hm[grid] != nil then
    cycle = i - hm[grid]
    rem = (1000000000-i)%cycle
    # puts [cycle, i, hm[grid]].to_s

    for i in 0...rem-1
      grid = transform(grid)
    end

    puts grid.each_with_index.map { |row, idx| row.map { |cell| cell == 'O' ? (grid.length-idx) : 0 } }.flatten.sum
    break
  end

  hm[grid] = i
end
