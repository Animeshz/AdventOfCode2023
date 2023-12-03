lines = []
while line=gets
  lines << line.chomp
end

ans = []
lines.each_with_index do |line, row|
  indexed_match = line.enum_for(:scan, /\d+/).map { Regexp.last_match }.map do |v| [v.begin(0), v.end(0)] end

  ans += indexed_match.filter_map do |start, back|
    line.slice(start, back).to_i if (row-1..row+1).any? do |i|
      (start-1..back).any? do |j|
        /[^\d\.]/ =~ lines[i][j] if i >= 0 && j >= 0 && i < lines.length && j < lines[0].length
      end
    end
  end
end

# puts ans.to_s
puts ans.sum
