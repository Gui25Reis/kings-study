/*
 Remove Consecutive Duplicates from Sorted Linked List
 Write a function "deleteDuplicates" that removes consecutive duplicate nodes in-place, retaining only the first node of each code. Return the head of the resulting list.

 Example

 Input

 head = [1, 2, 2, 2, 3, 4, 4, 5]
 Output

 [1, 2, 3, 4, 5]
 Explanation

 - Given 1→2→2→2→3→4→4→5.
 - Start at 1 (next is 2, no skip).
 - Move to 2; skip all consecutive 2's so that 2 links directly to 3 (removing two extra 2 nodes).
 - Now list is 1→2→3→4→4→5.
 - Move to 3 (next is 4, no skip).
 - At 4, skip the duplicate 4 so it links to 5.
 - The resulting list is 1→2→3→4→5.
 Input Format

 The first line n contains the length of the linked list
 The next n lines contains the elements of the linked list
 Example

 8
 1
 2
 2
 2
 3
 4
 4
 5
 here 8 is the length of the linked list followed by the nodes of the list.

 Constraints

 0 <= n <= 1000, where n is the number of nodes in the linked list
 -10^5 <= Node.val <= 10^5 for each node in the list
 The linked list is sorted in non-decreasing order: for each node u with successor v, u.val <= v.val
 Output Format

 The function returns one value: the head of the deduplicated list
 Sample Input 0

 0
 Sample Input 1

 1
 1
 Sample Output 1

 1
 
 link: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/remove-consecutive-duplicates-sorted-list
 */

// PS: classe já pré disponibilizada no exercício.
fileprivate class SinglyLinkedListNode {
    var data: Int
    var next: SinglyLinkedListNode?
    
    init(data: Int, next: SinglyLinkedListNode? = nil) {
        self.data = data
        self.next = next
    }
}


struct ExPR12 {
    func solution(input: InputProvider = DefaultInputProvider()) -> [Int] {
        guard let nInput = input.readLine(), let n = Int(nInput)
        else { return [] }

        var head: SinglyLinkedListNode? = nil
        var tail: SinglyLinkedListNode? = nil
        for _ in 0..<n {
            guard let line = input.readLine(), let value = Int(line) else { continue }
            let node = SinglyLinkedListNode(data: value)
            if head == nil {
                head = node
                tail = node
            } else {
                tail?.next = node
                tail = node
            }
        }

        var current = deleteDuplicates(head: head)
        var output = [Int]()
        while let node = current {
            output.append(node.data)
            current = node.next
        }
        return output
    }
}

/*
 Time: O(n) | Memory: O(1)
 */
fileprivate func deleteDuplicates(head: SinglyLinkedListNode?) -> SinglyLinkedListNode? {
    var actual = head
    
    while actual?.next != nil {
        let nextNode = actual?.next
        let nextValue = nextNode?.data
        
        if nextValue == actual?.data {
            actual?.next = nextNode?.next
        } else {
            actual = nextNode
        }
    }
    
    return head
}
