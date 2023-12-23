def possible_to_end_at(i, pattern, defect)
  i-defect+1 >= 0 && !pattern[i-defect+1..i].include?('.') &&
    (i-defect < 0 || pattern[i-defect] != '#') &&
    (i+1 > pattern.length || pattern[i+1] != '#')
end

ans = 0
while line=gets
  pattern, defects = line.split(' ')
  defects = defects.split(',').map(&:to_i)

  pattern = Array.new(5, pattern).join('?')
  defects = defects * 5

  prev, curr = Array.new(pattern.length+1) {0}, Array.new(pattern.length+1) {0}
  (0..(pattern.index('#')||pattern.length)).each { |i| prev[i] = 1 }

  for d in 0...defects.length
    curr[0] = 0
    for i in 0...pattern.length
      curr[i+1] = 0
      curr[i+1] += curr[i] if pattern[i] != '#'
      curr[i+1] += i-defects[d] >= 0 ? prev[i-defects[d]] : (d==0 ? 1 : 0) if possible_to_end_at(i, pattern, defects[d])
    end
    prev, curr = curr, prev
  end

  ans += prev[pattern.length]
end

puts ans
