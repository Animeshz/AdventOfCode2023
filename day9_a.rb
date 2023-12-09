ans = 0
while line=gets
  seq = line.scan(/-?\d+/).map(&:to_i)

  last = []
  while !seq.all? { |e| e == 0 } do
    last << seq[-1]
    seq = seq.each_cons(2).map { |a, b| b-a }
  end

  ans += last.reverse.reduce { |a, b| a+b }
end

puts ans
