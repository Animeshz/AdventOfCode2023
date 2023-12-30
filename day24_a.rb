slines = []
while line=gets
  s, v = line.split('@')
  s, v = s.scan(/-?\d+/).map(&:to_i), v.scan(/-?\d+/).map(&:to_i)

  # s(t) = vt+s
  slines << [v, s]
end

# x=f(t) y=g(t) => ax+by=c  & future intersection tester t=(x-x0)/v0 [test>0]
slines.map! { |v, s| [v[1], -v[0], v[1]*s[0]-v[0]*s[1], s[0], v[0]] }

# cramer's rule
intersections = slines.combination(2).filter_map do |l1, l2|
  d = l1[0]*l2[1]-l1[1]*l2[0]
  dx = l1[2]*l2[1]-l1[1]*l2[2]
  dy = l1[0]*l2[2]-l1[2]*l2[0]

  ans = d != 0 && (dx/d.to_f-l1[3])/l1[4] > 0 && (dx/d.to_f-l2[3])/l2[4] > 0 ? [dx/d.to_f, dy/d.to_f] : nil
end

# mn, mx = 7, 27
mn, mx = 200000000000000, 400000000000000
puts intersections.filter { |v| v[0] >= mn && v[0] <= mx && v[1] >= mn && v[1] <= mx }.length
