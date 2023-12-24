lengths = {[0, 0] => 0}

len, xmx, ymx, xmn, ymn = 0, 0, 0, 0, 0
while line=gets
  direxn, length = line.match(/(\w) (\d+)/).captures

  last = lengths.keys.last
  increment = case direxn
              when 'U' then [0, -1]
              when 'D' then [0, 1]
              when 'L' then [-1, 0]
              when 'R' then [1, 0]
              end

  for i in 1..length.to_i
    new = [last[0]+increment[0]*i, last[1]+increment[1]*i]
    xmx, ymx = [xmx, new[0]].max, [ymx, new[1]].max
    xmn, ymn = [xmn, new[0]].min, [ymn, new[1]].min

    lengths[new] = (len+=1)
  end
end

mod = lengths[[0, 0]]

scan, count = false, 0
for row in ymn..ymx
  for col in xmn..xmx
    count += 1 if scan && lengths[[col, row]].nil?

    a, b = lengths[[col, row]], lengths[[col, row+1]]
    next unless a && b

    decision = (a - b) % mod
    scan = !scan if [1, mod-1].include?(decision)
  end
end

puts count + mod
