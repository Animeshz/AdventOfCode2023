def op(lines)
  ans = 0

  rows = lines.length
  for i in 1..rows-1
    acc = 0
    for j in 1..i
      acc += lines[i-j].chars.each_with_index.count { |c, ix| c != lines[i+j-1][ix] } if lines[i-j] != nil and lines[i+j-1] != nil
    end
    return i*100 if acc == 1
  end

  cols = lines[0].length
  for i in 1..cols-1
    acc = 0
    for j in 1..i
      a = lines.filter_map { |line| line[i-j] }
      b = lines.filter_map { |line| line[i+j-1] }
      acc += a.each_with_index.count { |c, ix| c != b[ix] } if !a.empty? and !b.empty?
    end
    return i if acc == 1
  end
end

ans = 0
lines = []
while line=gets&.chomp
  if line == '' then
    ans += op(lines)
    lines = []
  else
    lines << line
  end
end
ans += op(lines) if !lines.empty?

puts ans
