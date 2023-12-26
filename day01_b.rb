valid = /(?=(one|two|three|four|five|six|seven|eight|nine|ten|0|1|2|3|4|5|6|7|8|9))/
valid_map = { one: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9 }

ans = 0
while line=gets
  scanned = line.scan(valid).flatten
  f, l = scanned[0], scanned[-1]

  f = valid_map[f.to_sym] || f
  l = valid_map[l.to_sym] || l

  ans += f.to_i * 10 + l.to_i
end

puts ans
