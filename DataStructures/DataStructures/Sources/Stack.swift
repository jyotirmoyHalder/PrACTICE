//
//  Stack.swift
//  DataStructures
//
//  Created by jyotirmoy_halder on 10/12/25.
//

struct Stack<Element: Equatable>: Equatable {
    // Storage
    private var storage: [Element] = []
    
    func isEmpty() -> Bool {
        return peek() == nil
    }
    
    init() { }
    
    init (_ elements: [Element]) {
        storage = elements
    }
    
    func peek() -> Element? {
        return storage.last
    }
    
    // Push
    mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    // Pop
    @discardableResult
    mutating func pop() -> Element? {
        return storage.popLast()
    }
    
}

extension Stack: CustomStringConvertible {
    var description: String {
        return storage
            .map { "\($0)" }
            .joined(separator: " ")
    }
}

extension Stack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.storage = elements
    }
}
