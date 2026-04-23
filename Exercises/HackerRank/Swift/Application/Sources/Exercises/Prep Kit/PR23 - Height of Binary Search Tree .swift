/*
 Height of Binary Search Tree
 Given the root of a binary search tree, return the height of the tree. Height is the number of nodes along the longest path from root to leaf.

 Example

 Input

 n = 7
 values = [4, 2, 6, 1, 3, 5, 7]
 leftChild = [1, 3, 5, -1, -1, -1, -1]
 rightChild = [2, 4, 6, -1, -1, -1, -1]
 Output

 3
 Explanation

 The tree is perfectly balanced with three levels:
 - Level 1: Node 4 (root)
 - Level 2: Nodes 2 and 6
 - Level 3: Leaves 1, 3, 5, 7 The longest path from root to any leaf has 3 nodes, so the height is 3.
 Input Format

 The first line contains n: integer denoting number of nodes in the binary search tree.
 The next n lines contains individual elements of the array. values[i] is the integer value stored in the iᵗʰ node.
 The next line contains an integer m denoting length of leftChild.
 The next m lines contains the elements of leftChild. leftChild[i] is the index of the left child of node i, or -1 if none.
 The next line contains an integer p denoting length of rightChild.
 The next p lines contains the elements of rightChild. rightChild[i] is the index of the right child of node i, or -1 if none.
 Constraints

 0 <= n <= 1000
 values.length == n
 leftChild.length == n
 rightChild.length == n
 For all 0 <= i < n: -10^9 <= values[i] <= 10^9
 All values[i] are unique
 For all 0 <= i < n: leftChild[i] == -1 or (0 <= leftChild[i] < n)
 For all 0 <= i < n: rightChild[i] == -1 or (0 <= rightChild[i] < n)
 For all 0 <= i < n: if leftChild[i] != -1 then values[leftChild[i]] < values[i]
 For all 0 <= i < n: if rightChild[i] != -1 then values[rightChild[i]] > values[i]
 The set of edges defined by (i, leftChild[i]) and (i, rightChild[i]) forms a single connected acyclic graph (a tree)
 Output Format

 Return a single integer representing the height of the tree: the number of nodes along the longest path from the root to any leaf. If n = 0, return 0.
 Sample Input 0

 1
 10
 1
 -1
 1
 -1
 Sample Output 0

 1
 Sample Input 1

 2
 5
 3
 2
 1
 -1
 2
 -1
 -1
 Sample Output 1

 2
 
 
 link: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/compute-height-of-bst
 */

import Foundation

struct ExPR23 {
    func solution(input: InputProvider = DefaultInputProvider()) -> Int {
        guard let nInput = input.readLine(), let n = Int(nInput)
        else { return 0 }

        var values = [Int]()
        for _ in 0..<n {
            guard let line = input.readLine(), let val = Int(line) else { continue }
            values.append(val)
        }

        guard let mInput = input.readLine(), let m = Int(mInput) else { return 0 }
        var leftChild = [Int]()
        for _ in 0..<m {
            guard let line = input.readLine(), let val = Int(line) else { continue }
            leftChild.append(val)
        }

        guard let pInput = input.readLine(), let p = Int(pInput) else { return 0 }
        var rightChild = [Int]()
        for _ in 0..<p {
            guard let line = input.readLine(), let val = Int(line) else { continue }
            rightChild.append(val)
        }

        return getBinarySearchTreeHeight(values: values, leftChild: leftChild, rightChild: rightChild)
    }
}


fileprivate func getBinarySearchTreeHeight(values: [Int], leftChild: [Int], rightChild: [Int]) -> Int {
    aiSolution2(values: values, leftChild: leftChild, rightChild: rightChild)
}


/*
 MARK: - AI Solution 1 — Recursão (DFS)

 Tempo: O(n) | Memória: O(h) onde h é a altura da árvore

 Exemplo 1 — árvore balanceada (test_01):
   values=[4,2,6,1,3,5,7], leftChild=[1,3,5,-1,-1,-1,-1], rightChild=[2,4,6,-1,-1,-1,-1]

   height(0) → 1 + max(height(1), height(2))
     height(1) → 1 + max(height(3), height(4))
       height(3) → 1 + max(height(-1), height(-1)) = 1 + max(0,0) = 1
       height(4) → 1 + max(height(-1), height(-1)) = 1 + max(0,0) = 1
     → 1 + max(1,1) = 2
     height(2) → 1 + max(height(5), height(6))
       height(5) → 1
       height(6) → 1
     → 1 + max(1,1) = 2
   → 1 + max(2,2) = 3 ✓

 Exemplo 2 — cadeia direita (test_05):
   values=[1,2,3,4], leftChild=[-1,-1,-1,-1], rightChild=[1,2,3,-1]

   height(0) → 1 + max(height(-1), height(1))
     height(1) → 1 + max(height(-1), height(2))
       height(2) → 1 + max(height(-1), height(3))
         height(3) → 1 + max(height(-1), height(-1)) = 1
       → 1 + max(0,1) = 2
     → 1 + max(0,2) = 3
   → 1 + max(0,3) = 4 ✓
 */
fileprivate func aiSolution1(values: [Int], leftChild: [Int], rightChild: [Int]) -> Int {
    guard !values.isEmpty else { return 0 }

    func height(_ index: Int) -> Int {
        guard index != -1 else { return 0 }
        return 1 + max(height(leftChild[index]), height(rightChild[index]))
    }

    return height(0)
}


/*
 MARK: - AI Solution 2 — BFS (nível por nível)

 Tempo: O(n) | Memória: O(n)

 Exemplo 1 — árvore balanceada (test_01):
   values=[4,2,6,1,3,5,7], leftChild=[1,3,5,-1,-1,-1,-1], rightChild=[2,4,6,-1,-1,-1,-1]

   queue=[0]       → height=1, filhos de 0: [1,2]
   queue=[1,2]     → height=2, filhos de 1: [3,4], filhos de 2: [5,6]
   queue=[3,4,5,6] → height=3, todos folhas → nextLevel=[]
   → 3 ✓

 Exemplo 2 — cadeia direita (test_05):
   values=[1,2,3,4], leftChild=[-1,-1,-1,-1], rightChild=[1,2,3,-1]

   queue=[0] → height=1, filho direito de 0: [1]
   queue=[1] → height=2, filho direito de 1: [2]
   queue=[2] → height=3, filho direito de 2: [3]
   queue=[3] → height=4, sem filhos → nextLevel=[]
   → 4 ✓
 */
fileprivate func aiSolution2(values: [Int], leftChild: [Int], rightChild: [Int]) -> Int {
    guard !values.isEmpty else { return 0 }

    var queue = [0]
    var height = 0

    while !queue.isEmpty {
        height += 1

        var nextLevel = [Int]()
        for index in queue {
            let left  = leftChild[index]
            let right = rightChild[index]
            if left  != -1 { nextLevel.append(left)  }
            if right != -1 { nextLevel.append(right) }
        }

        queue = nextLevel
    }

    return height
}

