/*
 Merge and Sort Intervals
 Given an array of intervals [startTime, endTime], merge all overlapping intervals and return a sorted array of non-overlapping intervals.

 Example

 Input

 intervals = [[1, 3], [2, 6], [8, 10], [15, 18]]
 Output

 [[1, 6], [8, 10], [15, 18]]
 Explanation

 - Step 1: Sort intervals by start time (already sorted).
 - Step 2: Initialize merged list with first interval [1,3].
 - Step 3: Compare [2,6] with last merged [1,3]. They overlap (2 ≤ 3), so merge into [1,6]. Step 4: Compare [8,10] with last merged [1,6]. No overlap (8 > 6), append [8,10].
 - Step 5: Compare [15,18] with last merged [8,10]. No overlap (15 > 10), append [15,18].

 Result: [[1,6],[8,10],[15,18]].
 Input Format

 The first line contains an integer denoting the number of intervals.
 The second line contains an integer denoting the length of individual interval array.
 Each of the next N lines contains two space-separated integers startTime and endTime
 Intervals may be provided in any order; duplicates and fully contained intervals are allowed.
 Example

 4
 2
 1 3
 2 6
 8 10
 15 18
 here, 4 is the number of intervals, 2 is the length of individual interval array, followed by the intervals.
 
 Link:
 https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/merge-and-sort-intervals
 */

struct Ex0026 {
    func solution(input: InputProvider = DefaultInputProvider()) -> [[Int]] {
        // Array qtd
        let qtdInput = input.readLine()
        
        guard let qtdInput, let qtd = Int(qtdInput)
        else { return [] }
        
        // Array lenght
        _ = input.readLine() /* Ignored input */
        
        // Matrix Creation
        lazy var matrix = [[Int]]()
        for _ in  0..<qtd {
            let dataInput = input.readLine()
            
            guard let dataInput else { continue }
            let array = dataInput
                .components(separatedBy: " ")
                .map { Int($0) ?? 0 }
            
            matrix.append(array)
        }
        
        return mergeHighDefinitionIntervals(intervals: matrix)
    }
}

// Complexity: O(n log n)
fileprivate func mergeHighDefinitionIntervals(intervals: [[Int]]) -> [[Int]] {
    if intervals.isEmpty || intervals.count == 1 {
        return intervals
    }
    
    // Sort all intervals f1rst by start time
    var array = intervals.sorted { $0[0] < $1[0] } // O(n log n)
    
    let first = array.removeFirst()
    
    var response = [first]
    
    var lastIndex: Int { response.count - 1 }
    
    for interval in array { // O(n)
        let lastInterval = response.last
        guard let lastInterval else { return [] }
        
        let starTimeNow = interval[0]
        let endTimeNow = interval[1]
        
        let endTimeRegistered = lastInterval[1]
        
        // Check if the start time (now) starts before the end (registered)
        let isMergable = starTimeNow <= endTimeRegistered
        
        // If time now is inside registerd one
        let isBetween = isMergable && endTimeNow < endTimeRegistered
        guard !isBetween else { continue }
        
        isMergable
        ? response[lastIndex][1] = endTimeNow
        : response.append(interval)
    }
    
    return response
}
