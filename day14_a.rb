lines = []
while line=gets&.chomp
  lines << line
end

rows = lines.length
cols = lines[0].length

obstruction = [0] * cols
load = 0
lines.each_with_index do |line, row|
  line.chars.each_with_index do |chr, col|
    case chr
    when 'O'
      load += rows - obstruction[col]
      obstruction[col] += 1
    when '#'
      obstruction[col] = row+1
    end
  end
end

puts load

# Optimized after solving (b)
#
# result = lines.map(&:chars).transpose.map { |row| row.chunk { |cell| cell == '#' }.flat_map { |is_obstacle, cells| is_obstacle ? cells : cells.sort.reverse } }.transpose.map(&:join)
# puts result.each_with_index.map { |row, idx| row.chars.map { |cell| cell == 'O' ? (result.length-idx) : 0 } }.flatten.sum
