vertices = [[0, 0]]
circum = 0
while line=gets
  length, direxn = line.match(/\(#(\w{5})(\d)\)/).captures
  length = length.to_i(16)

  xo, yo = vertices[-1]
  increment = case direxn
              when '3' then [0, -1]
              when '1' then [0, 1]
              when '2' then [-1, 0]
              when '0' then [1, 0]
              end
  vertices << [xo + increment[0]*length, yo + increment[1]*length]
  circum += increment[0].abs*length + increment[1].abs*length
end

shoelace_inside = vertices.each_cons(2).map { |p, q| p[0]*q[1]-q[0]*p[1] }.sum.abs/2 - circum/2 + 1
puts shoelace_inside + circum
