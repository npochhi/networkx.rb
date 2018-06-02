module NetworkX
  def generic_bfs_edges(G, source)
    raise KeyError, "There exists no node names #{source} in the given graph." unless G.node?(source)
    bfs_edges = []
    visited = [source]
    queue = Queue.new([source, G.neighbours(source)])
    while !queue.empty?
      parent, children = queue.pop
      children.each_key do |key|
        unless visited.include?(child)
          bfs_edges << [parent, child]
          visited << child
          queue.push([child, G.neighbours(child)])
        end
    end
    bfs_edges
  end

  def bfs_successors(G, source)
    bfs_edges = generic_bfs_edges(G, source)
    parent = source
    successors = {}
    bfs_edges.each do |u, v|
      successors[u] = [] if successors[u].nil?
      successors[u] << v
    end
    successors
  end

  def bfs_predecessors(G, source)
    bfs_edges = generic_bfs_edges(G, source)
    predecessors = {}
    bfs_edges.each { |u, v| predecessors[v] = u }
    predecessors
  end
end