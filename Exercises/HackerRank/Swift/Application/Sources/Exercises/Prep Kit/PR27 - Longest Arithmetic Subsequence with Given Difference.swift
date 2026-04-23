/*
 Longest Arithmetic Subsequence with Given Difference
 Given an array of integers and a positive integer k, find the length of the longest arithmetic progression with common difference k. Ignore duplicates.

 Example

 Input

 arr = [8, 1, -1, 0, 3, 6, 2, 4, 5, 7, 9]
 k = 2
 Output

 6
 Explanation

 Remove duplicates (none here) and consider the set of unique elements:

 We seek the longest arithmetic progression with difference k=2.

 Starting at -1 gives the sequence [-1,1,3,5,7,9] of length 6.
 No other starting point yields a longer progression, so the result is 6.
 Input Format

 The first line contains an integer n denoting the number of elements in the array.
 The next n lines contains an integer denoting elements in the array.
 The last line contains the value for integer k.
 Example

 11 → number of elements
 8 → elements of the array
 1
 -1
 0
 3
 6
 2
 4
 5
 7
 9
 2 → value of k
 Constraints

 0 <= arr.length <= 100000
 -10^9 <= arr[i] <= 10^9 for each 0 <= i < arr.length
 1 <= k <= 10^9
 Duplicates may appear in arr but should be ignored when forming the progression
 Output Format

 A single integer denoting the length of the longest arithmetic progression.
 Sample Input 0

 0
 5
 Sample Output 0

 0
 Sample Input 1

 1
 42
 7
 Sample Output 1

 1
 
 
 link: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/longest-arithmetic-subsequence-given-diff
 */


struct ExPR27 {
    func solution(input: InputProvider = DefaultInputProvider()) -> Int {
        guard let nInput = input.readLine(), let n = Int(nInput)
        else { return 0 }

        var arr = [Int]()
        for _ in 0..<n {
            guard let line = input.readLine(), let value = Int(line) else { continue }
            arr.append(value)
        }

        guard let kInput = input.readLine(), let k = Int(kInput)
        else { return 0 }

        return findLongestArithmeticProgression(arr: arr, k: k)
    }
}

/*
 Tempo: O(n log n) -- por conta do sorted
 Memória: O(n)
 */
fileprivate func findLongestArithmeticProgression(arr: [Int], k: Int) -> Int {
    guard !arr.isEmpty else { return 0 }
    
    if arr.count == 1 { return 1 } // Early return
    
    let unique = Set(arr)
    let sorted = unique.sorted()
    
    var ap = [Int:Int]()
    var maxLength = 1
    
    for num in sorted {
        let expected = num+k
        
        guard let ongoingLength = ap[num] else {
            ap[expected] = 1
            continue
        }
        
        ap[num] = nil
        
        let length = ongoingLength+1
        ap[expected] = length
        
        maxLength = (length > maxLength) ? length : maxLength
    }
    
    return maxLength
}


/*
 MARK: - AI Solution
 
 Tempo: O(n)
 Memória: O(n)
 */
fileprivate func aiSolution(arr: [Int], k: Int) -> Int {
    var dp = [Int: Int]() // dp[num] = tamanho da maior sequencia terminando em num
    var maxLength = 0

    let unique = Set(arr)

    for num in unique {
        dp[num] = (dp[num - k] ?? 0) + 1
        maxLength = max(maxLength, dp[num]!)
    }

    return maxLength
}
