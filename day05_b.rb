class Range
  def intersection(other)
    return nil if (self.max < other.begin or other.max < self.begin)
    [self.begin, other.begin].max..[self.max, other.max].min
  end
  def plus(n)
    self.begin+n..self.end+n
  end
  def minus(other)
    if other.kind_of?(Array) then
      return [self] if other.empty?
      return other.map(&self.method(:minus)).reduce { |a, b| a.product(b).filter_map { |p, q| p & q } }
    end
    return [self] if other.nil? || self.begin > other.end || self.end < other.begin
    return [] if self.begin >= other.begin && self.end <= other.end
    return [[self.begin, other.end].max+1..self.end] if self.begin >= other.begin && self.begin <= other.end
    return [self.begin..[self.end, other.begin].min-1] if self.end <= other.end && self.end >= other.begin
    [self.begin..[self.end, other.begin].min-1, [self.begin, other.end].max+1..self.end]
  end
  alias_method :&, :intersection
  alias_method :+, :plus
  alias_method :-, :minus
end

seeds_data = gets.scan(/\d+/).map(&:to_i)
seeds_range = seeds_data.each_slice(2).map { |start, step| (start..start+step-1) }

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
  Hash.new { |hash, key_range|
    rs = []

    mappable = md.filter_map do |dst, src, step|
      r = key_range & (src..src+step-1)
      # puts [key_range, (src..src+step-1), r].to_s if r
      ((rs << r) and r+(dst-src)) if r
    end

    non_mappable = key_range - rs

    mappable + non_mappable
  }
end

values = mappings.reduce(seeds_range) do |acc, reducer|
  acc.map(&reducer.method(:[])).flatten
end

puts values.map { |range| range.min }.min
