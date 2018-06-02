module NetworkX
  def dfs_edges(G, source, depth_limit=nil)
    raise KeyError, "There exists no node names #{source} in the given graph." unless G.node?(source)
    depth_limit = G.nodes.length if depth_limit.nil?
    dfs_edges = []
    visited = [source]
    stack = [[source, depth_limit, G.neighbours(source)]]
    while !stack.empty?
      parent, depth_now, children = stack.pop
      children.each_key do |key|
        unless visited.include?(child)
          dfs_edges << [parent, child]
          visited << child
          stack.push([child, depth_now - 1, G.neighbours(child)]) if depth_now > 1
        end
    end
    dfs_edges
  end

  def dfs_tree(G, source, depth_limit=nil)
    T = NetworkX::DiGraph.new
    T.add_node(source)
    T.add_edges_from(dfs_edges(G, source, depth_limit))
    T
  end

  def dfs_successors(G, source, depth_limit=nil)
    dfs_edges = dfs_edges(G, source, depth_limit)
    parent = source
    successors = {}
    dfs_edges.each do |u, v|
      successors[u] = [] if successors[u].nil?
      successors[u] << v
    end
    successors
  end

  def dfs_predecessors(G, source, depth_limit=nil)
    dfs_edges = dfs_edges(G, source, depth_limit)
    predecessors = {}
    dfs_edges.each { |u, v| predecessors[v] = u }
    predecessors
  end
end