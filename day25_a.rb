connections = Hash.new { |h, k| h[k] = [] }

while line=gets
  comp, conn = line.split(':')
  conn = conn.scan(/\w+/)

  # directed graph
  connections[comp].concat(conn)
  conn.each do |c| connections[c] << comp end
end

nodes = connections.keys
src, sinks = nodes[0], nodes[1..]

for sink in sinks
  # directed weighted graph (k=>[v] to k=>{v=>1})
  wt_graph = connections.transform_values { |cn| cn.to_h { |k| [k, 1] } }

  bfs = lambda {
    q = [src]
    q.each_with_object({}) { |at, par| wt_graph[at].each { |adj, cap| if cap > 0 && par[adj] == nil then par[adj] = at; q << adj end } }
  }

  # Ford-Fulkerson Algorithm
  maxflow = 0
  while (parents = bfs.call)[sink] != nil do
    s = sink
    while s != src do
      wt_graph[parents[s]][s] -= 1
      wt_graph[s][parents[s]] += 1
      s = parents[s]
    end
    maxflow += 1
  end

  if maxflow == 3 then
    # src sink belogs to two different groups
    src_group = parents.filter_map { |k, v| k if v }
    sink_group = nodes - src_group

    puts src_group.size * sink_group.size
    break
  end
end
