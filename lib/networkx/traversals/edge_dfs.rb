module NetworkX
  def edge_dfs(G, source, orientation=nil)
    def visit_all_edges(u, v)
      edges = []
      edges = [[u, v]] if G.class.name == 'Graph' || G.class.name == 'DiGraph'
      G.each { |u, all_edges| all_edges.each { |v, keys| keys.each_key { |k| edges << [u, v, k] } } }\
              if G.class.name == 'MultiGraph' || G.class.name == 'MultiDiGraph'

      edges
    end

    raise KeyError, "There exists no node names #{source} in the given graph." unless G.node?(source)
    case orientation
    when nil
      orientation = 'original'
    when 'reverse'
      G = G.reverse
    when 'ignore'
      G = G.to_multigraph if G.class.name == 'MultiDiGraph'
      G = G.to_undirected if G.class.name == 'DiGraph'
    else
      raise ArgumentError, 'Orientation given is not in the given set of options'
    end
    visited_edges = []
    visiged_nodes = []
    edges = {}
    traversed_edges = []
    stack = [start]
    while !stack.empty?
      current_node = stack.pop
      if !visited_nodes.include?(current_node)
        edges[current_node] = G.adj[current_node]
        visited_nodes << current_node
      end

      edges[current_node].each do |u, v|
        if !visited_edges.include?([u, v])
          traversed_edges += visit_all_edges(u, v)
          stack << v if G.class.name == 'DiGraph' || G.class.name == 'MultiDiGraph'
        end
      end
    end
    traversed_edges
  end
end