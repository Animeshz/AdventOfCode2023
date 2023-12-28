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
  last_pulse = id if maps[id].include? 'rx'
end
for ck, cv in conjunctions
  for mk, mv in maps
    cv << [mk, false] if mv.include?(ck)
  end
end

if conjunctions.include?(last_pulse) then
  lookup = conjunctions[last_pulse].map { |id, _| [id, true] }.to_h { |v| [v, nil] }
else
  lookup = {[last_pulse, false] => nil}
end

q = Queue.new
def press_btn(q, maps, flip_flops, conjunctions, count, lookup)
  for d in maps['broadcaster']
    q << ['broadcaster', false, d]
  end

  while !q.empty?
    src, pulse, dst = q.pop

    val = lookup.find { |k, v| k[0] == src && k[1] == pulse && v == nil }
    lookup[val[0]] = count if val

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
end

count = 0
while lookup.any? { |k, v| v == nil } do
  count += 1
  press_btn(q, maps, flip_flops, conjunctions, count, lookup)
end

puts lookup.values.reduce(&:*)
