/*
 Check for Non-Identical String Rotation
 Given two strings s1 and s2, return 1 if s2 is a rotation of s1 but not identical to s1, otherwise return 0.

 Example

 Input:

 s1 = abcde
 s2 = cdeab
 Output:

 True
 Explanation:

 - s2 ('cdeab') is a non-trivial rotation of s1 ('abcde').
 - If you rotate 'abcde' left by 2 positions, you get 'cdeab'.
 - Since s2 is not equal to s1 and is a rotation, the output is true.
 Input Format

 The first line contains the string s1, followed by s2 on the next line.
 Constraints

 1 <= |s1| <= 1000
 1 <= |s2| <= 1000
 |s1| = |s2|
 s1 & s2 both consists of lowercase English letters ('a'-'z') only
 Output Format

 The function returns a single BOOLEAN value, 1 for True and 0 for False
 Sample Input 0

 a
 a
 Sample Output 0

 0
 Sample Input 1

 a
 b
 Sample Output 1

 0
 
 link: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/check-non-identical-string-rotation/
 */

struct ExPR04 {
    func solution(input: InputProvider = DefaultInputProvider()) -> Bool {
        guard let s1 = input.readLine(),
              let s2 = input.readLine()
        else { return false }
        return isNonTrivialRotation(s1: s1, s2: s2)
    }
}

// aux
fileprivate extension String {
    subscript(index: Int) -> Character {
        self[self.index(self.startIndex, offsetBy: index)]
    }
}


fileprivate func isNonTrivialRotation(s1: String, s2: String) -> Bool {
    submission1(s1: s1, s2: s2)
}


/*
 ============
 SUBMITION 02
 ============
 */

/* KMP (Knuth-Morris-Pratt)
 
 Depois que a IA comentou sobre esse algoritmo, peguei a ideia e re-apliquei.
 */
fileprivate func submission2(s1: String, s2: String) -> Bool {
    guard s1.count > 1, s2.count > 1, s1.count == s2.count, s1 != s2
    else { return false }
    
    let comparison = s1 + s1
    
    var s2ind = 0
    var checkCount = 0
    
    for ind in 0..<comparison.count {
        let letter = comparison[ind]
        
        if letter != s2[s2ind] {
            checkCount = 0
            s2ind = 0
            
            // Checks if the actual letter start a new possible sub-string
            if letter != s2[s2ind] {
                continue
            }
        }
        
        s2ind += 1
        checkCount += 1
        if checkCount == s1.count {
            return true
        }
    }
        
    return false
}


/*
 ============
 SUBMITION 01
 ============
 */
fileprivate func submission1(s1: String, s2: String) -> Bool {
    guard s1.count > 1, s2.count > 1, s1.count == s2.count, s1 != s2
    else { return false }
    
    let firstLetter = s2.first!
    
    var startIndexes = [Int]()
    
    for ind in 0..<s1.count {
        let letter = s1[ind]
        
        if letter == firstLetter {
            startIndexes.append(ind)
        }
    }
    
    guard !startIndexes.isEmpty else { return false }
    
    for startIndex in startIndexes {
        var startIndex = startIndex
        var result = true
        
        for ind in 0..<s1.count {
            defer { startIndex += 1 }
            
            if startIndex == s1.count {
                startIndex = 0
            }
            
            let letter1 = s1[startIndex]
            let letter2 = s2[ind]
            
            if letter1 != letter2 {
                result = false
                break
            }
        }
        
        if result {
            return result
        }
    }
    
    return false
}


/*
 ============
 Swift Native
 ============
 */
fileprivate func aiSuggestion(s1: String, s2: String) -> Bool {
    (s1 + s1).contains(s2)
}
