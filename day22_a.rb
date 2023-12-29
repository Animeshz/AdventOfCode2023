require 'set'
require 'rb_heap'   # gem install rb_heap
Array.send(:include, Comparable)    # https://bugs.ruby-lang.org/issues/5574

# See this is probably overkill to use DSU here, but I'm just lazy
# Plus I should've used .each{} instead of for loops to make a few places one-liner
class DSU
  attr_accessor :iparent, :size
  def initialize
    @iparent = Hash.new { |h, k| h[k] = k }
    @size = Hash.new { |h, k| h[k] = 1 }
  end
  def parent(n)
    @iparent[n] == n ? n : (@iparent[n] = parent(@iparent[n]))
  end
  def union(n1, n2)
    # puts [n1, n2, parent(n1), parent(n2)].to_s
    n1, n2 = parent(n1), parent(n2)
    if n1 != n2 then
      if @size[n1] <= @size[n2] then
        @iparent[n1] = n2
        @size[n2] += @size[n1]
      else
        @iparent[n2] = n1
        @size[n1] += @size[n2]
      end
    end
  end
  def connected?(n1, n2)
    parent(n1) == parent(n2)
  end
end

q = Heap.new
dsu = DSU.new
while line=gets
  sx, sy, sz, ex, ey, ez = /(\d+),(\d+),(\d+)~(\d+),(\d+),(\d+)/.match(line).captures.map(&:to_i)
  q << [sz, ez, sx, ex, sy, ey]
end

final_pos = []
while lowest=q.pop
  sz, ez, sx, ex, sy, ey = lowest

  m = nil
  catch(:done) do
    while [sz, ez].min >= 1 do
      for i in sx..ex
        for j in sy..ey
          for k in sz..ez
            throw :done if (m = dsu.parent([i, j, k])) != [i, j, k]
            # in example, [1, 0, 1] should be blocked, return [0, 0, 0]
          end
        end
      end
      sz -= 1
      ez -= 1
    end
  end
  sz += 1
  ez += 1
  dsu.union([sx, sy, sz], [0, 0, 0]) if [sz, ez].min == 1
  dsu.union([sx, sy, sz], m) if m
  for i in sx..ex
    for j in sy..ey
      for k in sz..ez
        dsu.union([i, j, k], [sx, sy, sz])
      end
    end
  end
  final_pos << [sx, sy, sz, ex, ey, ez]
end

reverse_map = {}
final_pos.each_with_index do |fp, idx|
  sx, sy, sz, ex, ey, ez = fp
  for i in sx..ex
    for j in sy..ey
      for k in sz..ez
        reverse_map[[i, j, k]] = idx
      end
    end
  end
end
# final_pos.each { |v| puts v.to_s }

exclusion_set = Set.new
for fp in final_pos
  sx, sy, sz, ex, ey, ez = fp
  support = Set.new

  for i in sx..ex
    for j in sy..ey
      k = [sz, ez].min
      support << reverse_map[[i, j, k-1]] if reverse_map[[i, j, k-1]]
    end
  end
  if support.length <= 1 then
    exclusion_set.merge(support)
  end
  # puts [fp, support].to_s
end

puts final_pos.length - exclusion_set.length

