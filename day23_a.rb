grid = []
while line=gets&.chomp
  grid << line.chars
end

startx = grid[0].index { |c| c != '#' }

visit = Array.new(grid.length) { Array.new(grid[0].length) { false } }
valid = {
  '>' => [[1, 0]],
  '<' => [[-1, 0]],
  '^' => [[0, -1]],
  'v' => [[0, 1]],
  '.' => [[1, 0], [-1, 0], [0, 1], [0, -1]],
}
def longest(i, j, grid, visit, valid)
  return 0 if j == grid.length-1

  visit[j][i] = true
  ans = 0
  for dx, dy in valid[grid[j][i]]
    x, y = i+dx, j+dy
    next if x < 0 || x >= grid[0].length || y < 0 || y >= grid.length
    if visit[y][x] == false && grid[y][x] != '#' then
      ans = [ans, longest(x, y, grid, visit, valid)].max
    end
  end
  visit[j][i] = false
  # puts [i, j, ans].to_s
  return ans+1
end

puts longest(startx, 0, grid, visit, valid)
