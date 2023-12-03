lines = []
while line=gets
  lines << line.chomp
end

hm = {}
lines.each_with_index do |line, row|
  indexed_match = line.enum_for(:scan, /\d+/).map { Regexp.last_match }.map do |v| [v.begin(0), v.end(0)] end

  indexed_match.each do |start, back|
    (row-1..row+1).any? do |i|
      (start-1..back).any? do |j|
        if i >= 0 && j >= 0 && i < lines.length && j < lines[0].length && /\*/ =~ lines[i][j] then
          if !hm.has_key? [i, j] then hm[[i, j]] = [] end
          hm[[i, j]] << line.slice(start, back).to_i
        end
      end
    end
  end
end

ans = 0
hm.each do |k, v|
  ans += v.combination(2).map { |a, b| a*b }.sum
end

puts ans
