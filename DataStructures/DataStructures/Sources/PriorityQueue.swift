//
//  PriorityQueue.swift
//  DataStructures
//
//  Created by jyotirmoy_halder on 11/12/25.
//

struct PriorityQueue<Element> {
    private var heap: [Element] = []
    private let areSorted: (Element, Element) -> Bool // return true if a should be before b

    init(sort: @escaping (Element, Element) -> Bool) {
        self.areSorted = sort
    }

    var isEmpty: Bool { heap.isEmpty }
    var count: Int { heap.count }
    var peek: Element? { heap.first }

    mutating func push(_ element: Element) {
        heap.append(element)
        siftUp(from: heap.count - 1)
    }

    @discardableResult
    mutating func pop() -> Element? {
        guard !heap.isEmpty else { return nil }
        if heap.count == 1 { return heap.removeLast() }
        heap.swapAt(0, heap.count - 1)
        let popped = heap.removeLast()
        siftDown(from: 0)
        return popped
    }

    private mutating func siftUp(from index: Int) {
        var child = index
        var parent = (child - 1) / 2
        while child > 0 && areSorted(heap[child], heap[parent]) {
            heap.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }

    private mutating func siftDown(from index: Int) {
        var parent = index
        while true {
            let left = 2 * parent + 1
            let right = left + 1
            var candidate = parent

            if left < heap.count && areSorted(heap[left], heap[candidate]) {
                candidate = left
            }
            if right < heap.count && areSorted(heap[right], heap[candidate]) {
                candidate = right
            }
            if candidate == parent { return }
            heap.swapAt(parent, candidate)
            parent = candidate
        }
    }
}
