limit = { "red" => 12, "green" => 13, "blue" => 14 }

line_matcher = /Game (\d+): (.*)/
state_scanner = /(\d+) (\w+)/

ans = 0
while line=gets
  game, states = line_matcher.match(line).captures

  invalid = states.split('; ').any? do |state|
    matches = state.scan(state_scanner).any? { |n, color| n.to_i > limit[color] }
  end

  if !invalid then
    ans += game.to_i
  end
end

puts ans
