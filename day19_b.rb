class Range
  def less_than(other)
    [self.begin..other-1, other..self.end]
  end
  def greater_than(other)
    [other+1..self.end, self.begin..other]
  end
  alias_method :<, :less_than
  alias_method :>, :greater_than
end

workflows = {}
ans = 0
while line=gets
  if /(\w+){(.+)}/.match(line) then

    wf, cnds = Regexp.last_match.captures
    workflows[wf] = cnds.scan(/(?:([xmas][<>]\d+):)?(\w+)/)

  end
end

def acc(x, m, a, s, workflows, current='in')
  if current == "A" then
    mm = [x, m, a, s].map { |r| r.end-r.begin+1 }
    if mm.all? { |v| v > 0 } then
      # puts [x, m, a, s, mm.reduce(&:*)].to_s
      return mm.reduce(&:*)
    else
      return 0
    end
  elsif current == "R" then
    return 0
  end

  ans = 0
  for cnd in workflows[current]
    case cnd[0]
    when /^x/
      truth, x = eval(cnd[0] || '[x, 0..-1]')
      ans += acc(truth, m, a, s, workflows, cnd[1])
    when /^m/
      truth, m = eval(cnd[0] || '[m, 0..-1]')
      ans += acc(x, truth, a, s, workflows, cnd[1])
    when /^a/
      truth, a = eval(cnd[0] || '[a, 0..-1]')
      ans += acc(x, m, truth, s, workflows, cnd[1])
    when /^s/
      truth, s = eval(cnd[0] || '[s, 0..-1]')
      ans += acc(x, m, a, truth, workflows, cnd[1])
    when nil
      ans += acc(x, m, a, s, workflows, cnd[1])
    end
  end
  return ans
end

x, m, a, s = 1..4000, 1..4000, 1..4000, 1..4000
puts acc(x, m, a, s, workflows)
