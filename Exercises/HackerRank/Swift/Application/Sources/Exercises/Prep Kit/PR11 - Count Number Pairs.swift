/*
 Count Number Pairs
 Given a sorted array of positive integers and a target value, count the number of pairs (i, j) where i < j and array[i] + array[j] <= target.

 Example

 Input:

 prices = [1, 2, 3, 4, 5]
 budget = 7
 Output:

 8
 Explanation:

 We need pairs (i, j) with i < j and prices[i] + prices[j] ≤ 7. List all pairs:

 (1, 2) = 3 ≤ 7
 (1, 3) = 4 ≤ 7
 (1, 4) = 5 ≤ 7
 (1, 5) = 6 ≤ 7
 (2, 3) = 5 ≤ 7
 (2, 4) = 6 ≤ 7
 (2, 5) = 7 ≤ 7
 (3, 4) = 7 ≤ 7
 Pairs like (3,5)=8, (4,5)=9 exceed the budget. Total valid pairs = 8.

 Input Format

 The input is provided in two lines:

 The first line contains two space-separated integers n and budget, where:

 0 ≤ n ≤ 1000
 1 ≤ budget ≤ 10^9
 The second line contains n space-separated integers prices[0], prices[1], ..., prices[n-1], where:

 1 ≤ prices[i] ≤ 10^9 for all 0 ≤ i < n
 prices is sorted in non-decreasing order
 Constraints

 0 ≤ prices.length ≤ 1000
 1 ≤ prices[i] ≤ 10^9 for all 0 ≤ i < prices.length
 prices is sorted in non-decreasing order
 1 ≤ budget ≤ 10^9
 All inputs are integers
 Output Format

 Output a single integer representing the total count of unique index pairs (i, j) with 0 ≤ i < j < n such that prices[i] + prices[j] ≤ budget. If n < 2, output 0.

 Sample Input 0

 0
 100
 Sample Output 0

 0
 Sample Input 1

 1
 5
 5
 Sample Output 1

 0
 
 link: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/count-number-pairs
 */

struct ExPR11 {
    func solution(input: InputProvider = DefaultInputProvider()) -> Int {
        guard let nInput = input.readLine(), let n = Int(nInput)
        else { return 0 }

        guard let budgetInput = input.readLine(), let budget = Int(budgetInput)
        else { return 0 }

        var prices = [Int]()
        if n > 0 {
            guard let pricesInput = input.readLine() else { return 0 }
            prices = pricesInput.components(separatedBy: " ").compactMap { Int($0) }
        }

        return countAffordablePairs(prices: prices, budget: budget)
    }
}


/*
 Tempo: O(n) | Espaço: O(1)
 */
fileprivate func countAffordablePairs(prices: [Int], budget: Int) -> Int {
    guard prices.count > 1 else { return 0 }
    
    var i = 0
    var j = prices.count - 1
    
    var result = 0
    
    repeat {
        guard prices[i] + prices[j] <= budget else { j-=1; continue }
        result += j-i // j-i -> total de duplas validas com i.
        i+=1
                
    } while i < j
            
    return result
}

/*
 Tempo: O(n²) | Espaço: O(1)
 */
fileprivate func submission1(prices: [Int], budget: Int) -> Int {
    guard prices.count > 1 else { return 0 }
    
    var i = 0
    var j = prices.count - 1
    
    var result = 0
    
    while i <= j {
        let isIndexLower = i < j
        guard isIndexLower else {
            i += 1
            j = prices.count - 1
            continue
        }
        
        defer { j -= 1 }
        
        let sum = prices[i] + prices[j]
        guard sum <= budget else { continue }
        result += 1
        
    }
    
    return result
}
