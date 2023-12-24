require 'pp'
require 'rb_heap'  # gem install rb_heap

Array.send(:include, Comparable)    # https://bugs.ruby-lang.org/issues/5574

grid = []
while line=gets&.chomp
  grid << line.chars.map(&:to_i)
end

# I'll start at (m, n) and go towards (0, 0)
# because h(p) = manhattan distance = |x| + |y|

start = [grid[0].length-1, grid.length-1]
sh, sv = [start, 'h'], [start, 'v']

# A star search: f(p) = g(p) + h(p)
g_score = Hash.new { |h, k| h[k] = 1e9 }
f_score = Hash.new { |h, k| h[k] = 1e9 }

g_score[sh] = g_score[sv] = 0
f_score[sh] = f_score[sv] = start[0] + start[1]

open = Heap.new
open << [f_score[sh], f_score[sh], start, 'h']
open << [f_score[sv], f_score[sv], start, 'v']

while !open.empty? and open.peak()[2] != [0, 0] do
  # puts open.peak().to_s
  f, h, point, direxn = open.pop()

  for move in [-1, 1]
    gn = g_score[[point, direxn]]
    for d in 1..3
      xn, yn, ndirexn = direxn == 'h' ? [point[0]+move*d, point[1], 'v'] : [point[0], point[1]+move*d, 'h']
      next if xn < 0 || yn < 0 || xn > start[0] || yn > start[1]

      gn += grid[yn][xn]
      fn = gn + xn+yn

      if fn < f_score[[[xn, yn], ndirexn]] then
        g_score[[[xn, yn], ndirexn]] = gn
        f_score[[[xn, yn], ndirexn]] = fn

        open << [fn, xn+yn, [xn, yn], ndirexn]
      end
    end
  end
end

puts [g_score[[[0, 0] ,'v']], g_score[[[0, 0] ,'h']]].min + grid[start[1]][start[0]] - grid[0][0]
