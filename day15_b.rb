line = gets.chomp

ops = line.split(',').map { |seq| /(\w+)([=-])(\d?)/.match(seq)&.captures }.map { |lab, cmd, mp|
  dst = lab.chars.reduce(0) { |acc, e| (17 * (acc + e.ord)) % 256 }
  [lab, cmd, mp.to_i, dst]
}

boxes = Array.new(256) { {} }
ops.each { |l, c, m, d|
  case c
  when '=' then boxes[d][l] = m
  when '-' then boxes[d].delete(l)
  end
}

ans = boxes.each_with_index.map { |box, idx|
  box.to_a.each_with_index.map { |bx, i| (idx+1) * (i+1) * bx[1] }.sum
}.sum

puts ans
