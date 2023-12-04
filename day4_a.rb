line_matcher = /Card +(\d+): (.*)/
num_scanner = /\d+/

ans = 0
while line=gets
  card, numbers = line_matcher.match(line).captures

  winning, having = numbers.split('|')

  intersection = winning.scan(num_scanner) & having.scan(num_scanner)
  if !intersection.empty? then
    ans += 1 << (intersection.length-1)
  end
end

puts ans
