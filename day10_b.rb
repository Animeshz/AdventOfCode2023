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

# [current_point, direction] => length_record (DFS)
base = [[start, :up], [start, :down], [start, :left], [start, :right]]

lengths = base.lazy.map { |point, direction|
  lstore = {}
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

    lstore[[i, j]] = len
    break lstore if lines[i][j] == 'S'
    break {} if !direction
  end
}.find { |x| !x.empty? }

points_inside = lines.each_with_index.map { |line, row|
  scan, count = false, 0
  line.chars.each_with_index { |char, col|
    count += 1 if scan && lengths[[row, col]].nil?

    a, b = lengths[[row, col]], lengths[[row+1, col]]
    next unless a && b

    decision = (a - b) % lengths[start]
    scan = !scan if [1, lengths[start] - 1].include?(decision)
  }
  count
}

puts points_inside.sum
