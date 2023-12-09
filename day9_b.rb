ans = 0
while line=gets
  seq = line.scan(/-?\d+/).map(&:to_i)

  first = []
  while !seq.all? { |e| e == 0 } do
    first << seq[0]
    seq = seq.each_cons(2).map { |a, b| b-a }
  end

  ans += first.reverse.reduce { |a, b| b-a }
end

puts ans
