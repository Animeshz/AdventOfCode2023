line_matcher = /Card +(\d+): (.*)/
num_scanner = /\d+/

card_count = {}
ans = 0
while line=gets
  card, numbers = line_matcher.match(line).captures
  card = card.to_i

  if !card_count.has_key? card then card_count[card] = 0 end
  card_count[card] += 1

  winning, having = numbers.split('|')

  intersection = winning.scan(num_scanner) & having.scan(num_scanner)
  if !intersection.empty? then
    for i in card+1..card+intersection.length do
      if !card_count.has_key? i then card_count[i] = 0 end
      card_count[i] += card_count[card]
    end
  end
end

puts card_count.values.sum
