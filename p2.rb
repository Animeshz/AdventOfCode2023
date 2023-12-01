valid = /(?=(one|two|three|four|five|six|seven|eight|nine|ten|0|1|2|3|4|5|6|7|8|9))/
valid_map = { one: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9 }

ans = 0
while line=gets
  scanned = line.scan(valid).flatten
  f, l = scanned[0].to_sym, scanned[-1].to_sym

  f = if valid_map.has_key? f then valid_map[f] else f.to_s.to_i end
  l = if valid_map.has_key? l then valid_map[l] else l.to_s.to_i end

  ans += f * 10 + l
end

puts ans
