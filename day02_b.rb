line_matcher = /Game (\d+): (.*)/
state_scanner = /(\d+) (\w+)/

ans = 0
while line=gets
  game, states = line_matcher.match(line).captures

  threshold = { "red" => 0, "green" => 0, "blue" => 0 }
  states.split('; ') do |state|
    state.scan(state_scanner) do |n, color|
      threshold[color] = [threshold[color], n.to_i].max
    end
  end

  cube_power = threshold["red"] * threshold["green"] * threshold["blue"]
  ans += cube_power
end

puts ans
