time = gets.gsub(/\s+/, '').split(':')[1].to_i
distance = gets.gsub(/\s+/, '').split(':')[1].to_i

p, d = 0, 0
while d <= distance
  p += 1
  d = p*(time-p)
end

min = p
max = time-p

ans = max-min+1
puts ans
