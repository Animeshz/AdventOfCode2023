seeds = gets.scan(/\d+/).map(&:to_i)

mappings_data = []
while line=gets do
  if /-to-/ =~ line then
    mappings_data << []
  end

  map = line.scan(/\d+/).map(&:to_i)
  if !map.empty? then
    mappings_data[-1] << map
  end
end

mappings = mappings_data.map do |md|
  Hash.new { |hash, key|
    m = md.find { |dst, src, step| key >= src && key < src+step }
    if m then m[0]+(key-m[1]) else key end
  }
end

values = mappings.reduce(seeds) do |acc, reducer|
  acc.map(&reducer.method(:[]))
end

puts values.min
