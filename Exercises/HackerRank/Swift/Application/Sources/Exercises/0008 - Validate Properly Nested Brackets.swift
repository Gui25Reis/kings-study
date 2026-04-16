/*
 Validate Properly Nested Brackets
 Given a string, check if all brackets ('()', '{}', '[]') are properly matched and nested. Return 1 if valid, otherwise return 0.

 Example

 Input

 code_snippet = if (a[0] > b[1]) { doSomething(); }
 Output

 1
 Explanation

 All brackets are properly matched: '(' with ')', '[' with ']', and '{' with '}'. No mismatches or improper nesting.
 Input Format

 The function takes a single parameter, code_snippet, which is a STRING.
 Constraints

 0 <= code_snippet.length <= 1000
 code_snippet consists of printable ASCII characters (character codes 32 to 126 inclusive)
 code_snippet may contain any combination of '(', ')', '{', '}', '[', ']', letters, digits, symbols, and whitespace
 code_snippet may be empty
 Output Format

 The function returns a BOOLEAN value, 1 for True and 0 for False.
 Sample Input 0

 int x = 42; // no brackets here
 Sample Output 0

 1
 Sample Input 1

 () {} []
 Sample Output 1

 1
 
 link: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/validate-properly-nested-brackets
 */

struct Ex0008 {
    func solution(input: InputProvider = DefaultInputProvider()) -> Bool {
        guard let line = input.readLine() else { return true }
        return areBracketsProperlyMatched(code_snippet: line)
    }
}

/* Solução otimizada: O(n) */
fileprivate func areBracketsProperlyMatched(code_snippet: String) -> Bool {
    /*
     Se existir um valor = é um brascket
     Se o valor é vazio = brascket que abre
     */
    let dict = [
        "{": "",
        "}": "{",
        "[": "",
        "]": "[",
        "(": "",
        ")": "(",
    ]
    
    var stack = [String]()
    
    for char in code_snippet {
        let brascket = "\(char)"
        let expected = dict[brascket]
        
        guard let expected else { continue }
        
        let isBrascketOpener = expected.isEmpty
        
        // Se o primeiro é inválido, já encerra.
        if stack.isEmpty && !isBrascketOpener {
            return false
        }
        
        if stack.isEmpty || isBrascketOpener {
            stack.append(brascket)
            continue
        }
        
        let lastIndex = stack.count-1
        let lastBracket = stack[lastIndex]
        
        if lastBracket == expected  {
            stack.remove(at: lastIndex)
        }
    }
    
    return stack.isEmpty
}


/*
 Primeira solução apenas pra fazer funfar
 
 PS: remove(at:) eh O(n), pois precisa organizar o vetor pós remoção
 fazendo essa solução ser O(n²) (quadrática) e não O(n) (linear)
 */
fileprivate func solution1(code_snippet: String) -> Bool {
    let dict = [
        "{": "}",
        "}": "",
        "[": "]",
        "]": "",
        "(": ")",
        ")": "",
    ]
    
    var stack = [String]()
    
    // Separete braskets
    for char in code_snippet {
        let str = "\(char)"
        let bracket = dict[str]
        
        guard let _ = bracket else { continue }
        stack.append(str)
    }
    
    // If is not even, is missing a case
    if stack.count%2 != 0 {
        return false
    }
    
    // Validates stack
    var ind = 0
    while stack.count > 0 && ind >= 0 {
        
        let brascket = stack[ind]
        
        let expected = dict[brascket]
        guard let expected, !expected.isEmpty else { return false }
        
        let nextBrascket = stack[ind+1]
        
        if nextBrascket == expected {
            stack.remove(at: ind+1)
            stack.remove(at: ind)
            ind -= 1
            continue
        }
        ind += 1
    }
    return true
}
