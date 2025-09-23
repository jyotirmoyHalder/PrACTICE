//
//  main.swift
//  PrACTICE
//
//  Created by jyotirmoy_halder on 23/9/25.
//

import Foundation

let arraySize = 5 // Read and dropteh array size line.
// Knowing the size of the array beforehand is needed for some languages
// But as a readLine() returns the whole line, Swift doesn't need it!
var array = [Int]()
array.reserveCapacity(arraySize)
for i in 0..<arraySize {
    array.append(solve(for: i))
}

let fiveZs = Array(repeating: "Z", count: 5)
print(fiveZs)

func solve(for index: Int) -> Int {
    return index * 2
}

print(array)
print(array)

//array = readLine()!.components(separatedBy: " ").map{ Int($0)! }
//let result = array.reduce(0, +)
//print(result)
//
//print(1 &+ 1)

