ans = 0

while line=gets
  f = line.split('').find do |c| c >= '0' && c <= '9' end
  l = line.reverse.split('').find do |c| c >= '0' && c <= '9' end

  ans += f.to_i * 10 + l.to_i
end

puts ans
