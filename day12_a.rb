ans = 0
while line=gets
  pattern, defects = line.split(' ')
  pattern.gsub!(/^\.*|\.*$/, '')
  defects = defects.split(',').map(&:to_i)

  permutations = ['']
  pattern.chars.each do |c|
    if c == '?' then
      permutations = permutations.map { |v| v + '.' } + permutations.map { |v| v + '#' }
    else
      permutations = permutations.map { |v| v + c }
    end
  end

  defect_matcher = Regexp.new '^\.*' + defects.map { |l| '#{' + l.to_s + '}' }.join('\.+') + '\.*$'
  filtered = permutations.filter { |p| p.match(defect_matcher) }
  ans += filtered.size
end

puts ans
