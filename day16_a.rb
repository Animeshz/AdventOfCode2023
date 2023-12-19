grid = []
while line=gets&.chomp
  grid << line.chars
end

visit = Array.new(grid.length) { Array.new(grid[0].length) { '.' } }
call = {}
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

mark_and_move(0, 0, 1, 0, grid, visit, call)
puts visit.flatten.count('#')
