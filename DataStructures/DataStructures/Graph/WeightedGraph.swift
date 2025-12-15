//
//  WeightedGraph.swift
//  DataStructures
//
//  Created by jyotirmoy_halder on 10/12/25.
//

public struct GraphEdge: Equatable {
    let source: Int
    let destination: Int
    let weight: Int

    init(_ source: Int, _ destination: Int, _ weight: Int) {
        self.source = source
        self.destination = destination
        self.weight = weight
    }

    func getSource() -> Int { source }
    func getDestination() -> Int { destination }
    func getWeight() -> Int { weight }
}

public class WeightedGraph {
     let vertices: Int
    // Array of adjacency lists: for each vertex, a list (array) of outgoing edges
    private var adjacencyList: [[GraphEdge]]

    public init(vertices: Int) {
        self.vertices = vertices
        self.adjacencyList = Array(repeating: [], count: vertices + 1)
    }

    public func addDirectedEdge(source: Int, destination: Int, weight: Int) {
        let edge = GraphEdge(source, destination, weight)
        adjacencyList[source].append(edge)
    }

    public func addUndirectedEdge(source: Int, destination: Int, weight: Int) {
        let edgeAB = GraphEdge(source, destination, weight)
        let edgeBA = GraphEdge(destination, source, weight)
        adjacencyList[source].append(edgeAB)
        adjacencyList[destination].append(edgeBA)
    }

    public func removeDirectedEdge(source: Int, destination: Int) {
        guard source >= 0, source < vertices else { return }
        if let idx = adjacencyList[source].firstIndex(where: { $0.destination == destination }) {
            adjacencyList[source].remove(at: idx)
        }
    }

    public func removeUndirectedEdge(source: Int, destination: Int) {
        removeDirectedEdge(source: source, destination: destination)
        removeDirectedEdge(source: destination, destination: source)
    }

    // Mirrors Java's `getVertices()` returning the adjacency list
    public func getVertices() -> [[GraphEdge]] {
        adjacencyList
    }
}


func printWeightedGraph() {
    let graph = WeightedGraph(vertices: 5)
    graph.addUndirectedEdge(source: 1, destination: 2, weight: 4)
    graph.addUndirectedEdge(source: 1, destination: 5, weight: 6)
    graph.addUndirectedEdge(source: 2, destination: 5, weight: 1)
    graph.addDirectedEdge(source: 4, destination: 2, weight: 7)
    graph.addDirectedEdge(source: 5, destination: 3, weight: 8)

    // Print the graph
    let vertices = graph.getVertices()
    for i in 0..<vertices.count {
        let neighbors = vertices[i].map { String($0.getDestination()) }.joined(separator: " ")
        print("Vertex \(i) is connected to: \(neighbors)")
    }
}

public class MinimumSpanningTree {

    // Prim's algorithm: returns list of edges in the MST starting from startVertex (default 1)
    public func primMST(graph: WeightedGraph, startVertex: Int = 1) -> [GraphEdge] {
        let verticesAdj = graph.getVertices() // [[GraphEdge]] indexed 0...vertices
        let n = graph.vertices
        if n <= 0 { return [] }

        // inMST marks whether a vertex is already included
        var inMST = Array(repeating: false, count: n + 1) // 1-based indexing safe guard

        // Min-heap by edge weight
        var pq = PriorityQueue<GraphEdge>(sort: { $0.getWeight() < $1.getWeight() })

        var mstEdges: [GraphEdge] = []

        // Clamp start to valid range (1...n) since graph uses 1-based indices in usage
        let start = max(1, min(startVertex, n))
        inMST[start] = true

        // Push all edges from the start vertex
        if start < verticesAdj.count {
            for e in verticesAdj[start] { pq.push(e) }
        }

        while let currentEdge = pq.pop() {
            let dest = currentEdge.getDestination()
            if dest < 0 || dest > n { continue }

            // Skip if destination already in MST
            if inMST[dest] { continue }

            // Take this edge
            mstEdges.append(currentEdge)
            inMST[dest] = true

            // Add all outgoing edges from the new vertex
            if dest < verticesAdj.count {
                for e in verticesAdj[dest] { pq.push(e) }
            }
        }

        return mstEdges
    }

    // Kruskal's algorithm (naive cycle check via set like the Java example)
    // Note: This naive approach does not fully prevent cycles across larger components.
    // For a correct Kruskal implementation, use Union-Find (Disjoint Set Union).
    public func kruskalMST(graph: WeightedGraph) -> [GraphEdge] {
        let verticesAdj = graph.getVertices()
        let n = graph.vertices
        if n <= 0 { return [] }

        var pq = PriorityQueue<GraphEdge>(sort: { $0.getWeight() < $1.getWeight() })
        for i in 0..<verticesAdj.count {
            for e in verticesAdj[i] { pq.push(e) }
        }

        var mstEdges: [GraphEdge] = []
        var inMST: Set<Int> = []

        while let edge = pq.pop() {
            let u = edge.getSource()
            let v = edge.getDestination()
            // Skip if it forms a cycle per the simplistic set logic (matches provided Java)
            if inMST.contains(u) && inMST.contains(v) {
                continue
            }
            mstEdges.append(edge)
            inMST.insert(u)
            inMST.insert(v)
        }

        // Optional: print MST edges
        // print("Minimum Spanning Tree Edges:")
        // for e in mstEdges {
        //     print("\(e.getSource()) - \(e.getDestination()) : \(e.getWeight())")
        // }

        return mstEdges
    }
}

public class DijkstraShortestPath {

    // Returns array of shortest distances from source to every vertex (1-based indexing safe)
    // Mirrors the Java approach using a priority queue of GraphEdge prioritized by cumulative weight
    public func dijkstraShortestPath(graph: WeightedGraph, source: Int) -> [Int] {
        let verticesAdj = graph.getVertices() // [[GraphEdge]] (0..n)
        let n = graph.vertices
        if n <= 0 { return [] }

        // Use Int.max to represent infinity
        var distance = Array(repeating: Int.max, count: n + 1) // 1-based safe guard

        // Min-heap by edge weight (cumulative)
        var pq = PriorityQueue<GraphEdge>(sort: { $0.getWeight() < $1.getWeight() })

        // Clamp source to [1, n] since this graph is used as 1-based elsewhere in this file
        let s = max(1, min(source, n))
        distance[s] = 0
        pq.push(GraphEdge(s, s, 0))

        while let currentEdge = pq.pop() {
            let u = currentEdge.getDestination() // like Java: destination is the vertex being expanded

            // If we popped an entry with a weight larger than our best-known, skip (stale heap entry)
            if currentEdge.getWeight() > distance[u] { continue }

            if u < verticesAdj.count {
                for edge in verticesAdj[u] {
                    // edge: u -> v with edge.getWeight() cost
                    let v = edge.getDestination()
                    if distance[u] == Int.max { continue }
                    let newDistance = distance[u] + edge.getWeight()
                    if newDistance < distance[v] {
                        distance[v] = newDistance
                        // push cumulative weight to v
                        pq.push(GraphEdge(edge.getSource(), edge.getDestination(), newDistance))
                    }
                }
            }
        }

        return distance
    }
}

// Example runner mirroring the Java main (uses 1-based vertices here for consistency with other examples)
func demoDijkstra() {
    let graph = WeightedGraph(vertices: 6)
    graph.addUndirectedEdge(source: 1, destination: 2, weight: 4)
    graph.addUndirectedEdge(source: 1, destination: 3, weight: 4)
    graph.addUndirectedEdge(source: 2, destination: 3, weight: 2)
    graph.addUndirectedEdge(source: 2, destination: 4, weight: 3)
    graph.addUndirectedEdge(source: 2, destination: 6, weight: 6)
    graph.addUndirectedEdge(source: 2, destination: 5, weight: 1)
    graph.addUndirectedEdge(source: 4, destination: 6, weight: 2)
    graph.addUndirectedEdge(source: 5, destination: 6, weight: 3)

    let dsp = DijkstraShortestPath()
    let distances = dsp.dijkstraShortestPath(graph: graph, source: 1)
    // Print distances (indices 1...n)
    for i in 1...graph.vertices {
        let d = distances[i]
        if d == Int.max {
            print("Vertex \(i): unreachable")
        } else {
            print("Vertex \(i): \(d)")
        }
    }
}

public class GraphColoring {
    // Returns a map (dictionary) from vertex -> color (1, 2, 3, ...)
    public func colorGraph(graph: WeightedGraph) -> [Int: Int] {
        let verticesAdj = graph.getVertices() // [[GraphEdge]]
        var colorMap: [Int: Int] = [:]

        // Iterate 1...n (skip 0th bucket)
        let n = graph.vertices
        guard n >= 1 else { return [:] }

        for vertex in 1...n {
            if vertex >= verticesAdj.count { continue }

            // Gather neighbor colors
            var neighborColors = Set<Int>()
            for edge in verticesAdj[vertex] {
                if let c = colorMap[edge.getDestination()] {
                    neighborColors.insert(c)
                }
            }

            // Find the smallest positive color not used by neighbors
            var color = 1
            while neighborColors.contains(color) {
                color += 1
            }
            colorMap[vertex] = color
        }

        return colorMap
    }
}

// Demo with 1-based vertices (consistent with other code in your file)
func demoGraphColoringOneBased() {
    // Map Java’s 0..5 to 1..6 for consistency
    let graph = WeightedGraph(vertices: 6)
    graph.addUndirectedEdge(source: 1, destination: 2, weight: 4)
    graph.addUndirectedEdge(source: 1, destination: 3, weight: 4)
    graph.addUndirectedEdge(source: 2, destination: 3, weight: 2)
    graph.addUndirectedEdge(source: 3, destination: 4, weight: 3)
    graph.addUndirectedEdge(source: 3, destination: 5, weight: 6)
    graph.addUndirectedEdge(source: 3, destination: 6, weight: 1)
    graph.addUndirectedEdge(source: 4, destination: 5, weight: 2)
    graph.addUndirectedEdge(source: 6, destination: 5, weight: 3)

    let gc = GraphColoring()
    let colorMap = gc.colorGraph(graph: graph)

    print("Node colors:")
    var maxColor = 0
    for vertex in 1...graph.vertices {
        if let color = colorMap[vertex] {
            maxColor = max(maxColor, color)
            print("Node \(vertex) -> Color \(color)")
        }
    }
    print("Minimum number of colors used: \(maxColor)")
}
