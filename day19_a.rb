workflows = {}
ans = 0
while line=gets
  if /(\w+){(.+)}/.match(line) then

    wf, cnds = Regexp.last_match.captures
    workflows[wf] = cnds.scan(/(?:([xmas][<>]\d+):)?(\w+)/)

  elsif /{x=(\d+),m=(\d+),a=(\d+),s=(\d+)}/.match(line) then

    x, m, a, s = Regexp.last_match.captures.map(&:to_i)

    current = 'in'
    while !"AR".include?(current) do
      for cnd in workflows[current]
        if eval(cnd[0] || 'true') then
          current = cnd[1]
          break
        end
      end
    end

    if current == "A" then
      ans += x+m+a+s
    end

  end
end

puts ans
