/*
 Count Connected Components in Network
 Given n computers labeled 0 to n-1 and a list of bidirectional communication links, find the number of connected components.

 Example

 Input

 n = 4
 links = [[0, 1], [2, 3]]
 Output

 2
 Explanation

 There are 4 computers: 0, 1, 2, and 3. Links connect 0-1 and 2-3. Computers 0 and 1 form one group since they are directly connectable. Similarly, 2 and 3 form another group. There are no connections between the two groups, so the number of isolated communication groups is 2.
 Input Format

 The first line contains an integer m denoting the length of links.
 The second line denotes the length of individual elements of array links.
 The next m lines contains individual elements of links.
 The last line contains the value of n.
 Example

 2
 2
 0 1
 2 3
 4
 Constraints

 1 <= n <= 1000
 0 <= links.length <= n * (n - 1) / 2
 links[i].length == 2 for each valid i
 0 <= links[i][0] < n
 0 <= links[i][1] < n
 links[i][0] != links[i][1] for each valid i (No self-loops)
 Each pair [a, b] is bidirectional, i.e., [a, b] and [b, a] are considered the same link
 No duplicate links (i.e., no repeated [a, b] or [b, a]) in links
 All values in each link are integers
 Output Format

 Returns a single INTEGER representing the number of distinct isolated communication groups
 Sample Input 0

 1
 2
 0 1
 2
 Sample Output 0

 1
 Sample Input 1

 3
 2
 0 1
 1 2
 0 2
 3
 Sample Output 1

 1
 
 
 link: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/count-connected-components-in-network
 */


struct ExPR22 {
    func solution(input: InputProvider = DefaultInputProvider()) -> Int {
        guard let mInput = input.readLine(), let m = Int(mInput) else { return 0 }

        // tamanho de cada link (sempre 2, descartado)
        _ = input.readLine()

        var links = [[Int]]()
        for _ in 0..<m {
            guard let line = input.readLine() else { continue }
            let parts = line.components(separatedBy: " ").compactMap { Int($0) }
            guard parts.count == 2 else { continue }
            links.append(parts)
        }

        guard let nInput = input.readLine(), let n = Int(nInput) else { return 0 }

        return countIsolatedCommunicationGroups(links: links, n: n)
    }
}

/*
 PS: não funcionou! -- Test Case 10
 */
fileprivate func countIsolatedCommunicationGroups(links: [[Int]], n: Int) -> Int {
    guard !links.isEmpty else { return n }
    
    var cache = [Int:Int]()
    var count = 0
    
    for link in links {
        let n0 = link[0]
        let n1 = link[1]
        
        let qtdN0 = cache[n0]
        let qtdN1 = cache[n1]
        
        if qtdN0 == nil && qtdN1 == nil {
            count += 1
        }

        cache[n0] = (cache[n0] ?? 0) + 1
        cache[n1] = (cache[n1] ?? 0) + 1
    }
    
    count += n-cache.count
    return count
}
