module NetworkX
  def self.descendants(graph, source)
    raise ArgumentError, 'Source is not present in the graph!' unless graph.node?(source)
    des = single_source_shortest_path_length(graph, source).map { |u, _| u }.uniq
    des - [source]
  end

  def self.ancestors(graph, source)
    raise ArgumentError, 'Source is not present in the graph!' unless graph.node?(source)
    anc = single_source_shortest_path_length(graph.reverse, source).map { |u, _| u }.uniq
    anc - [source]
  end

  def self.topological_sort(graph)
    raise ArgumentError, 'Topological Sort not defined on undirected graphs!' unless graph.directed?
    nodes = []
    indegree_map = Hash[graph.nodes.each_key.map { |u| [u, graph.in_degree(u)] if graph.in_degree(u) > 0 }.compact]
    zero_indegree = graph.nodes.each_key.map { |u| u if graph.in_degree(u) == 0 }.compact

    while !zero_indegree.empty?
      node = zero_indegree.shift
      raise ArgumentError, 'Graph changed during iteration!' unless graph.nodes.key?(node)
      graph.adj[node].each do |child, _|
        indegree_map[child] -= 1
        if indegree_map[child] == 0
          zero_indegree << child
          indegree_map.delete(child)
        end
      end
      nodes << node
    end
    raise ArgumentError, 'Graph contains cycle or graph changed during iteration!' unless indegree_map.empty?
    nodes
  end
end
