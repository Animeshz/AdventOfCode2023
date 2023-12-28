maps = {}
flip_flops = {}
conjunctions = {}

while line=gets
  type, id, dsts = line.match(/(%|&)?(\w+) -> (.+)/).captures

  case type
  when '%' then flip_flops[id] = false
  when '&' then conjunctions[id] = []
  end

  maps[id] = dsts.scan(/\w+/)
end
for ck, cv in conjunctions
  for mk, mv in maps
    cv << [mk, false] if mv.include?(ck)
  end
end

q = Queue.new
def press_btn(q, maps, flip_flops, conjunctions, low, high)
  for d in maps['broadcaster']
    q << ['broadcaster', false, d]
  end
  low += 1

  while !q.empty?
    src, pulse, dst = q.pop
    low += 1 if !pulse
    high += 1 if pulse

    if flip_flops.include?(dst) && !pulse
      flip_flops[dst] = !flip_flops[dst]
      out = flip_flops[dst]
    elsif conjunctions.include?(dst)
      conjunctions[dst].find { |s, r| s == src }[1] = pulse
      out = !conjunctions[dst].all? { |s, r| r }
    else
      # puts [src, pulse, dst].to_s
      next
    end

    # puts [src, pulse, dst, out, maps[dst]].to_s
    for d in (maps[dst] || [])
      q << [dst, out, d]
    end
  end

  return low, high
end

low, high = 0, 0
cycle, count, mod = {flip_flops => 0}, 0, 0
for _ in 0...1000
  count += 1

  low, high = press_btn(q, maps, flip_flops, conjunctions, low, high)

  if cycle[flip_flops] != nil
    mod = count - cycle[flip_flops]
    break
  end

  cycle[flip_flops] = count
end

puts mod
if mod == 0
  # no cycle
  puts low * high
else
  # cycle
  low *= 1000 / mod
  high *= 1000 / mod
  rem = 1000 % mod

  for _ in 0...rem
    low, high = press_btn(q, maps, flip_flops, conjunctions, low, high)
  end

  puts low * high
end
