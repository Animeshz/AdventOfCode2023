time = gets.scan(/\d+/).map(&:to_i)
distance = gets.scan(/\d+/).map(&:to_i)

ans = 1
time.each_with_index do |t, i|
  p, d = 0, 0
  while d <= distance[i]
    p += 1
    d = p*(t-p)
  end

  min = p
  max = t-p

  ways = max-min+1
  ans *= ways
end

puts ans
