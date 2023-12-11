lines = []
while line=gets&.chomp
  lines << line
end
lines.map!(&:chars)

rows_inc = lines.each_with_object([]) { |row, acc| acc << (acc.last || 0) + (row.all? { |c| c == '.' } ? 1 : 0) }
cols_inc = lines.transpose.each_with_object([]) { |col, acc| acc << (acc.last || 0) + (col.all? { |c| c == '.' } ? 1 : 0) }

coordinates = []
lines.each_with_index do |line, row|
  line.each_with_index do |char, col|
    coordinates << [row, col] if char == '#'
  end
end

min_dists = coordinates.combination(2).map { |a, b|
  (b[1]-a[1]).abs + (b[0]-a[0]).abs + (rows_inc[b[0]]-rows_inc[a[0]]).abs*999999 + (cols_inc[b[1]]-cols_inc[a[1]]).abs*999999
}

puts min_dists.sum
