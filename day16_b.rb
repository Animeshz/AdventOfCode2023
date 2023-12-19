grid = []
while line=gets&.chomp
  grid << line.chars
end

def mark_and_move(x, y, dx, dy, grid, visit, call)
  return if x < 0 or y < 0 or visit[y] == nil or visit[y][x] == nil
  return if call[[x, y, dx, dy]] == true

  visit[y][x] = '#'
  call[[x, y, dx, dy]] = true

  case grid[y][x]
  when '\\'
    mark_and_move(x+dy, y+dx, dy, dx, grid, visit, call)
  when '/'
    mark_and_move(x-dy, y-dx, -dy, -dx, grid, visit, call)
  when '|'
    if dy == 0 then
      mark_and_move(x, y+1, 0, 1, grid, visit, call)
      mark_and_move(x, y-1, 0, -1, grid, visit, call)
    else
      mark_and_move(x+dx, y+dy, dx, dy, grid, visit, call)
    end
  when '-'
    if dx == 0 then
      mark_and_move(x+1, y, 1, 0, grid, visit, call)
      mark_and_move(x-1, y, -1, 0, grid, visit, call)
    else
      mark_and_move(x+dx, y+dy, dx, dy, grid, visit, call)
    end
  else
    mark_and_move(x+dx, y+dy, dx, dy, grid, visit, call)
  end
end

ans = 0
for i in 0...grid.length
  for j in 0...grid[0].length
    if i == 0 then
      call = {}
      visit = Array.new(grid.length) { Array.new(grid[0].length) { '.' } }
      mark_and_move(j, i, 0, 1, grid, visit, call)
      ans = [ans, visit.flatten.count('#')].max
    end
    if j == 0 then
      call = {}
      visit = Array.new(grid.length) { Array.new(grid[0].length) { '.' } }
      mark_and_move(j, i, 1, 0, grid, visit, call)
      ans = [ans, visit.flatten.count('#')].max
    end
    if i == grid.length-1 then
      call = {}
      visit = Array.new(grid.length) { Array.new(grid[0].length) { '.' } }
      mark_and_move(j, i, 0, -1, grid, visit, call)
      ans = [ans, visit.flatten.count('#')].max
    end
    if j == grid[0].length-1 then
      call = {}
      visit = Array.new(grid.length) { Array.new(grid[0].length) { '.' } }
      mark_and_move(j, i, -1, 0, grid, visit, call)
      ans = [ans, visit.flatten.count('#')].max
    end
  end
end

puts ans
