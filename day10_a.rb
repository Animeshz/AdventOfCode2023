lines = []
while line=gets&.chomp
  lines << line
end

start = lines.index { |line| /S/.match(line) }&.then { |i| [i, lines[i].index(/S/)] }

# [direction, new_point_sym] => direction
map = {
  [:up, '|'] => :up,
  [:up, 'F'] => :right,
  [:up, '7'] => :left,
  [:down, '|'] => :down,
  [:down, 'L'] => :right,
  [:down, 'J'] => :left,
  [:left, '-'] => :left,
  [:left, 'L'] => :up,
  [:left, 'F'] => :down,
  [:right, '-'] => :right,
  [:right, 'J'] => :up,
  [:right, '7'] => :down,
}

# [current_point, direction] => loop_length (DFS)
base = [[start, :up], [start, :down], [start, :left], [start, :right]]

length = base.lazy.map { |point, direction|
  len = 0
  while true do
    len += 1
    point = case direction
                when :up then [point[0]-1, point[1]]
                when :down then [point[0]+1, point[1]]
                when :left then [point[0], point[1]-1]
                when :right then [point[0], point[1]+1]
                end
    i, j = point
    direction = map[[direction, lines[i][j]]]
    # puts [point, direction].to_s

    break len if lines[i][j] == 'S'
    break 0 if !direction
  end
}.find { |x| x.nonzero? }

puts length/2
