class Array
  def kind()
    freq = self.group_by(&:itself).transform_values(&:size)
    case freq.size
    when 5 then 0   # high
    when 4 then 1   # one-pair
    when 3 then freq.value?(2) ? 2 : 3  # two-pair / three-of-a-kind
    when 2 then freq.value?(2) ? 4 : 5  # full-house / four-of-a-kind
    when 1 then 6   # five-of-a-kind
    end
  end
end

lines = []
while line=gets
  hand, bid = line.split(' ')
  lines << [hand.chars, bid.to_i]
end

ordering = "23456789TJQKA"
lines.sort! { |a, b|
  (a[0].kind <=> b[0].kind).nonzero? || a[0].zip(b[0]).map { |c1, c2| ordering.index(c1) <=> ordering.index(c2) }.find { |r| r != 0 }
}

puts lines.each_with_index.map { |l, i| l[1] * (i+1) }.sum
