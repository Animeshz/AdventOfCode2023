require 'set'
require 'pp'

lines = []
while line=gets&.chomp
  lines << line
end

len = lines.length  # only assumption: rows == cols
steps = 26501365
mod = steps%len

start = lines.index { |line| /S/.match(line) }&.then { |i| [lines[i].index(/S/), i] }

snapshot = []
visited = Set.new
q = [[start[0], start[1], 2*len+mod]]

while !q.empty? do
  x, y, s = q.shift
  snapshot << [x, y] if (x+y)%2 == steps%2
  # puts [x, y, s].to_s

  for dx, dy in [[1, 0], [-1, 0], [0, 1], [0, -1]]
    nx, ny = x+dx, y+dy
    next if lines[ny%len][nx%len] == '#' or visited.include?([nx, ny]) or s <= 0
    visited << [nx, ny]
    q << [nx, ny, s-1]
  end
end
# pp snapshot

block = snapshot.filter { |x, y| x-start[0] >= 0 && x-start[0] < len && y-start[1] >= 0 && y-start[1] < len }.length

bottom_right = [
  snapshot.filter { |x, y| x-start[0] >= 2*len && y-start[1] >= 0 && y-start[1] < len }.length,
  snapshot.filter { |x, y| x-start[0] >= len && x-start[0] < 2*len && y-start[1] >= 0 && y-start[1] < len }.length,
]
up_right = [
  snapshot.filter { |x, y| x-start[0] >= 2*len && y-start[1] < 0 && y-start[1] >= -len }.length,
  snapshot.filter { |x, y| x-start[0] >= len && x-start[0] < 2*len && y-start[1] < 0 && y-start[1] >= -len }.length,
]
up_left = [
  snapshot.filter { |x, y| x-start[0] < -2*len && y-start[1] < 0 && y-start[1] >= -len }.length,
  snapshot.filter { |x, y| x-start[0] >= -2*len && x-start[0] < -len && y-start[1] < 0 && y-start[1] >= -len }.length,
]
bottom_left = [
  snapshot.filter { |x, y| x-start[0] < -2*len && y-start[1] >= 0 && y-start[1] < len }.length,
  snapshot.filter { |x, y| x-start[0] >= -2*len && x-start[0] < -len && y-start[1] >= 0 && y-start[1] < len }.length,
]
# puts bottom_right.to_s
# puts up_right.to_s
# puts up_left.to_s
# puts bottom_left.to_s


b = steps/len
ans = 4*(b*(b-1)/2)*block + b*(bottom_right[1]+up_right[1]+up_left[1]+bottom_left[1]) + (b+1)*(bottom_right[0]+up_right[0]+up_left[0]+bottom_left[0])
# puts snapshot.length
# puts [b, (ans-snapshot.length), 4*(b*(b-1)/2)*block, b*(bottom_right[1]+up_right[1]+up_left[1]+bottom_left[1]), (b+1)*(bottom_right[0]+up_right[0]+up_left[0]+bottom_left[0])].to_s

# idk lol, just observed the pattern, might be something missing in my logic that's overestimating
ans -= b*(b-1)/2*(len-1)
ans -= b % 2 == 0 ? 0 : 1

puts ans
