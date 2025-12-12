//
//  BinaryTreeCase.swift
//  DataStructures
//
//  Created by jyotirmoy_halder on 10/12/25.
//

import XCTest
@testable import DataStructures

final class BinaryTreeCase: XCTestCase {
    
    var tree: BinaryNode<Int> = {
        let zero = BinaryNode(value: 0)
        let one = BinaryNode(value: 1)
        let five = BinaryNode(value: 5)
        let seven = BinaryNode(value: 7)
        let eight = BinaryNode(value: 8)
        let nine = BinaryNode(value: 9)
        let ten = BinaryNode(value: 10)
        
        seven.leftChild = one
        one.leftChild = zero
        one.rightChild = five
        seven.rightChild = nine
        nine.leftChild = five
        zero.leftChild = ten
        
        return seven
    }()
    
    func test_visualizeBinaryTree() {
        print(tree.description)
    }
    
    func test_traverseInOrder() {
        
    }
    
    func test_traversePreOrder() {
        
    }
    
    func test_traversePostOrder() {
        
    }
}
