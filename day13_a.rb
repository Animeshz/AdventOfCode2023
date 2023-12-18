def op(lines)
  ans = 0

  rows = lines.length
  for i in 1..rows-1
    mirror = true
    for j in 1..i
      if lines[i-j] != nil and lines[i+j-1] != nil and lines[i-j] != lines[i+j-1] then
        mirror = false
        break
      end
    end
    if mirror then
      ans += 100*i
    end
  end

  cols = lines[0].length
  for i in 1..cols-1
    mirror = true
    for j in 1..i
      a = lines.filter_map { |line| line[i-j] }
      b = lines.filter_map { |line| line[i+j-1] }
      if !a.empty? and !b.empty? and a != b then
        mirror = false
        break
      end
    end
    if mirror then
      ans += i
    end
  end

  return ans
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
