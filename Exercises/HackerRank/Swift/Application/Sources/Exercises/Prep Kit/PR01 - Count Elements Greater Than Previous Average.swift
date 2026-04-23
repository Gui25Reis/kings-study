/*
 Given an array of positive integers, return the number of elements that are strictly greater than the average of all previous elements. Skip the first element.

 Example

 Input

 responseTimes = [100, 200, 150,300]
 Output

 2
 Explanation

 - Day 0: 100 (no previous days, skip)
 - Day 1: 200 > average(100) = 100 → count = 1
 - Day 2: 150 vs average(100, 200) = 150 → not greater → count = 1
 - Day 3: 300 > average(100, 200, 150) = 150 → count = 2 Return 2.
 Input Format

 The first line contains an integer n (0 ≤ n ≤ 1000), the number of days.
 If n > 0, the next n lines contains an integer representing responseTimes[i].
 If n = 0, the second line is omitted or empty.
 Example

 4
 100
 200
 150
 300
 here 4 is the length of array, followed by the elements of array on each line.
 
 Link:
 https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/count-elements-greater-than-previous-average
 */

struct ExPR01 {
    func solution(input: InputProvider = DefaultInputProvider()) -> Int {
        let dataInput = input.readLine()
        
        guard let dataInput, let qtd = Int(dataInput)
        else { return 0 }
        
        lazy var array = [Int]()
        for _ in  0..<qtd {
            let dataInput = input.readLine()
            
            guard let dataInput, let number = Int(dataInput)
            else { continue }
            
            array.append(number)
        }
        
        return countResponseTimeRegressions(responseTimes: array)
    }
}


fileprivate func countResponseTimeRegressions(responseTimes: [Int]) -> Int {
    if responseTimes.isEmpty || responseTimes.count == 1 {
        return 0
    }
    
    lazy var valids = 0
    
    var array = responseTimes
    let first = array.removeFirst()
    
    var lastSum = first
    
    var count = 1
    for number in array {
        count += 1
        lastSum += number
        
        let average = lastSum / count

        guard number > average else { continue }
        valids += 1
    }
    
    return valids
}
