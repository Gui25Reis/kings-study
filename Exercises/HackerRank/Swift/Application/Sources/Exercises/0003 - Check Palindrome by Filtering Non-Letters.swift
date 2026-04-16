/*
 Check Palindrome by Filtering Non-Letters
 Given a string containing letters, digits, and symbols, determine if it reads the same forwards and backwards when considering only alphabetic characters (case-insensitive).

 Example

 Input

 code = A1b2B!a
 Output

 1
 Explanation

 - Step 1: Extract only letters → ['A','b','B','a']
 - Step 2: Convert to lowercase → ['a','b','b','a']
 - Step 3: Compare sequence forward and backward: 'abba' == 'abba' → true
 Input Format

 A string code containing letters (A–Z, a–z), digits (0–9), and symbols
 Constraints

 0 <= code.length <= 1000
 For all 0 <= i < code.length: 33 <= ASCII(code[i]) <= 126
 code contains only printable ASCII characters (letters, digits, symbols)
 Output Format

 Return a boolean value: 1 if true & 0 if false.
 Sample Input 0

 Z
 Sample Output 0

 1
 Sample Input 1

 abc123cba
 Sample Output 1

 1
 
 link: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/check-palindrome-filter-non-letters
 */

struct Ex0003 {
    func solution(input: InputProvider = DefaultInputProvider()) -> Bool {
        guard let code = input.readLine() else { return false }
        return isAlphabeticPalindrome(code: code)
    }
}


/*
 65 -> A
 90 -> Z
 
 97 -> a
 122 -> z
 
 // diff: 32
 */

fileprivate func isAlphabeticPalindrome(code: String) -> Bool {
    guard !code.isEmpty else { return true }
    
    var asciiValues = [UInt8]()
    
    // checks each letter
    for char in code {
        guard let ascii = char.asciiValue else { continue }
        
        // lowercase
        if ascii >= 65 && ascii <= 90 {
            let asciiLowercase = ascii + 32
            asciiValues.append(asciiLowercase)
            continue
        }
        
        // uppercase
        if ascii >= 97 && ascii <= 122 {
            asciiValues.append(ascii)
        }
    }
    
    guard asciiValues.count > 1 else { return true }
    
    // Check if it is a palindrome.
    var firstIndex = 0
    var lastIndex = asciiValues.count - 1
    
    var result = false
    
    while firstIndex < lastIndex {
        defer {
            firstIndex += 1
            lastIndex -= 1
        }
        
        let isSameLetter = asciiValues[firstIndex] == asciiValues[lastIndex]
        
        guard isSameLetter else { return false }
        result = isSameLetter
    }
    
    return result
}


/*
 ============
 AI SOLUTION!
 ============
 */
fileprivate func aiSolution(code: String) -> Bool {
    let letters = code.filter { $0.isLetter }.lowercased()
    return letters == String(letters.reversed())
}


/*
 ============
 SUBMITION 02
 ============
 */
fileprivate extension String {
    subscript(index: Int) -> Character {
        self[self.index(self.startIndex, offsetBy: index)]
    }
}

fileprivate func submittion2(code: String) -> Bool {
    guard !code.isEmpty else { return false }
    
    var letters = ""
    
    // Separa as letras
    for char in code {
        guard let ascii = char.asciiValue else { continue }
        
        // Letra maiúscula
        if ascii >= 65 && ascii <= 90 {
            let asciiLowercase = ascii + 32
            let unicode = UnicodeScalar(asciiLowercase)
            let letter = Character(unicode)
            letters.append(letter)
            continue
        }
        
        // Letra minúscula
        if ascii >= 97 && ascii <= 122 {
            letters.append(char)
        }
    }
    
//    print("Code: \(code) | Letter: \(letters)")
    
    guard !letters.isEmpty else { return false }
    
    if letters.count == 1 {
        return true
    }
    
    // Verifica se é um palíndromo.
    var firstIndex = 0
    var lastIndex = letters.count-1
    
    var result = false
    
    while firstIndex < lastIndex {
        defer {
            firstIndex += 1
            lastIndex -= 1
        }
        
        let isSameLetter = letters[firstIndex] == letters[lastIndex]
        
        guard isSameLetter else { return false }
        result = isSameLetter
    }
    
    return result
}


/*
 ============
 SUBMITION 01
 ============
 */
fileprivate func submittion1(code: String) -> Bool {
    /*
     Your submission contains non ASCII characters, we dont accept submissions with non ASCII characters for this challenge.
     */
    guard !code.isEmpty else { return false }
    
    var letters = [Character]()
    
    // Separa as letras
    for char in code {
        guard let ascii = char.asciiValue else { continue }
        
        // Letra maiúscula
        if ascii >= 65 && ascii <= 90 {
            let asciiLowercase = ascii + 32
            let unicode = UnicodeScalar(asciiLowercase)
            let letter = Character(unicode)
            letters.append(letter)
            continue
        }
        
        // Letra minúscula
        if ascii >= 97 && ascii <= 122 {
            letters.append(char)
        }
    }
    
//    print("Code: \(code) | Letter: \(letters)")
    
    guard !letters.isEmpty else { return false }
    
    if letters.count == 1 {
        return true
    }
    
    // Verifica se é um palíndromo.
    var firstIndex = 0
    var lastIndex = letters.count-1
    
    var result = false
    
    while firstIndex < lastIndex {
        defer {
            firstIndex += 1
            lastIndex -= 1
        }
        
        let isSameLetter = letters[firstIndex] == letters[lastIndex]
        
        guard isSameLetter else { return false }
        result = isSameLetter
    }
    
    return result
}
