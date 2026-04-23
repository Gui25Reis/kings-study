/*
 Min-Tracking Stack Implementation
 Implement a stack that supports push, pop, top, and getMin operations in O(1) time, where getMin returns the minimum element.

 Example

 Input

 n = 10
 operations = ['push 2', 'push 0', 'push 3', 'push 0', 'getMin', 'pop', 'getMin', 'pop', 'top', 'getMin']
 Output

 [0,0,0,0]
 Explanation

 - push 2 → stack = [2], min = 2 2.
 - push 0 → stack = [2,0], min = 0 3.
 - push 3 → stack = [2,0,3], min = 0 4.
 - push 0 → stack = [2,0,3,0], min = 0 5.
 - getMin → returns 0 6.
 - pop → removes 0, stack = [2,0,3], min = 0 7.
 - getMin → returns 0 8.
 - pop → removes 3, stack = [2,0], min = 0 9.
 - top → returns 0 10. getMin → returns 0
 Input Format

 operations: array of n number of operations, each matching exactly one of:
 "push x" where x is an integer and 0 <= x <= 100
 "pop"
 "top"
 "getMin"
 The next n lines contain the value of elements in the array.
 At any point in the sequence, the number of "pop" operations performed so far must be strictly less than the number of preceding "push" operations (so that the stack is never empty when "pop", "top", or "getMin" is called).
 Constraints

 For each "push x" operation, 0 <= x <= 100 and x is an integer
 Each entry in operations must match the pattern ^(push \d+|pop|top|getMin)$
 pop, top, and getMin operations are only invoked when the stack is non-empty
 Total number of push operations <= n where n is the length of operations array
 Output Format

 An integer array of length equal to the total number of "top" and "getMin" operations in the input
 Sample Input 0

 2
 push 5
 getMin
 Sample Output 0

 5
 Sample Input 1

 2
 push 0
 top
 Sample Output 1

 0
 
 
 link: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/min-tracking-stack
 */


struct ExPR09 {
    func solution(input: InputProvider = DefaultInputProvider()) -> [Int] {
        guard let nInput = input.readLine(), let n = Int(nInput)
        else { return [] }

        var operations = [String]()
        for _ in 0..<n {
            guard let line = input.readLine() else { continue }
            operations.append(line)
        }

        return processCouponStackOperations(operations: operations)
    }
}

// MARK: - Solution
fileprivate enum Operations {
    case push(Int)
    case pop
    case top
    case min
    
    init(with data: [String]) {
        self = switch data[0] {
        case "push": .push(Int(data[1])!)
        case "pop": .pop
        case "top": .top
        default: .min
        }
    }
}

fileprivate struct Stack {
    private var array = [Int]()
    private var minStack = [Int]()
    
    /* Operations */
    var top: Int { array.last ?? 0 }
    var min: Int { minStack.last ?? 0 }
    
    public init() { /* Allows instance */ }
    
    mutating func pop() {
        array.removeLast()
        minStack.removeLast()
    }
    
    mutating func push(_ value: Int) {
        array.append(value)
        
        if let min = minStack.last {
            return minStack.append(value <= min ? value : min)
        }
        minStack.append(value)
    }
}

fileprivate func processCouponStackOperations(operations: [String]) -> [Int] {
    var stack = Stack()

    var opArray = [Int]()
    for commands in operations {
        let commandsSplit = commands.components(separatedBy: " ")
        let operation = Operations(with: commandsSplit)

        switch operation {
        case .push(let value): stack.push(value)
        case .pop: stack.pop()
        case .top: opArray.append(stack.top)
        default: opArray.append(stack.min)
        }
    }

    return opArray
}


// MARK: - AI Solution
fileprivate struct AIStack {
    private var stack = [Int]()
    private var minStack = [Int]() // cada posição guarda o mínimo até aquele momento

    var top: Int { stack.last ?? 0 }
    var getMin: Int { minStack.last ?? 0 }

    mutating func push(_ value: Int) {
        stack.append(value)
        let currentMin = minStack.last.map { min($0, value) } ?? value
        minStack.append(currentMin)
    }

    mutating func pop() {
        stack.removeLast()
        minStack.removeLast()
    }
}
