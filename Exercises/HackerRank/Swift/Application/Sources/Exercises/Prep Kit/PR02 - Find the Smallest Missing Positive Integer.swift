/*
 Find the Smallest Missing Positive Integer
 Given an unsorted array of integers, find the smallest positive integer not present in the array in O(n) time and O(1) extra space.

 Example

 Input

 orderNumbers = [3, 4, -1, 1]
 Output

 2
 Explanation

 We want the smallest positive missing integer.

 Start with [3, 4, -1, 1]
 - i=0: value 3 ⇒ swap with index 2 ⇒ [-1, 4, 3, 1]
 - i=0: value -1 is out of range ⇒ move on
 - i=1: value 4 ⇒ swap with index 3 ⇒ [-1, 1, 3, 4]
 - i=1: value 1 ⇒ swap with index 0 ⇒ [1, -1, 3, 4]
 - now 1 at index 0, 3 at 2, 4 at 3; -1 remains at index 1

 Scan from index 0:
 index 0 has 1 (correct), index 1 has -1 (not 2) ⇒ missing positive is 2
 Input Format

 An integer n on the first line, where 0 ≤ n ≤ 1000.
 The next n lines contains an integer representing orderNumbers[i].
 Example

 4
 3
 4
 -1
 1
 here 4 is the length of array, followed by the elements of array on each line.

 Constraints

 0 <= orderNumbers.length <= 1000
 -10^9 <= orderNumbers[i] <= 10^9 for all 0 <= i < orderNumbers.length
 Duplicates are allowed in orderNumbers
 Negative numbers and zero are allowed in orderNumbers
 Output Format

 A single integer denoting the smallest positive order number (≥1) that does not appear in the input array.
 Sample Input 0
 0
 
 Sample Output 0
 1
 
 Sample Input 1
 1
 1
 
 Sample Output 1
 2
 
 link: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/find-smallest-missing-positive-integer
 */

struct ExPR02 {
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
        
        return findSmallestMissingPositive(orderNumbers: array)
    }
}

// MARK: - Solutions
fileprivate func findSmallestMissingPositive(orderNumbers array: [Int]) -> Int {
    submission1(orderNumbers: array)
}

/*
 Ao usar o while, mesmo que faça mais interações que o tamanho do array,
 ainda continua sendo uma solução O(n).
 
 O(n) quer dizer crescimento linear, onde n nesse caso seria a quantidade
 de interações necessárias para ajustar o array.
 
 Por isso que a solução da IA usa while e funciona, e nessa do draft não funciona
 pois se limita ao tamanho do vetor. Isso faz com que o vetor não fique completamente
 ajustado.
 */
fileprivate func draftNewSolution(orderNumbers array: [Int]) -> Int {
    guard !array.isEmpty else { return 1 }
    
    if array.count == 1 {
        return array.first == 1 ? 2 : 1
    }
    
    var array = array
    var ind = 0
    
    for _ in 0..<array.count {
        let num = array[ind]
        guard num > 0 else {
            ind += 1
            continue
        }
        
        let correctIndex = num - 1
        
        guard correctIndex != ind, correctIndex < array.count else {
            ind += 1
            continue
        }
        
        let otherNum = array[correctIndex]
        
        array[correctIndex] = num
        array[ind] = otherNum
    }
    
    var minPositive = 1
    for ind in 0..<array.count {
        let num = array[ind]
        
        if num < minPositive {
            continue
        }
        
        if num == minPositive { // Casos repetidos
            minPositive += 1
            continue
        }
    }
    
    return minPositive
}

// MARK: AI solution

/*
 Cyclic Sort — O(n) tempo, O(1) espaço

 Fase 1 — colocar cada número na posição correta (num → índice num-1):
   Enquanto array[ind] está fora do lugar, troca com a posição correta.
   Só avança ind quando o elemento atual já está no lugar (ou é inválido).
   Dessa forma, cada elemento é movido no máximo uma vez → O(n) no total.

 Fase 2 — varrer o array já organizado:
   O primeiro índice onde array[ind] != ind+1 revela o menor positivo faltando.
   Se todos estiverem corretos, o faltante é n+1.

 A diferença para a solução anterior:
   - Usa while em vez de for na fase 1 → garante que ind só avança quando o slot está resolvido
   - A fase 2 compara diretamente array[ind] com ind+1, sem depender de ordenação completa
 */
fileprivate func aiSolution(orderNumbers: [Int]) -> Int {
    guard !orderNumbers.isEmpty else { return 1 }

    var array = orderNumbers

    // Fase 1: cyclic sort
    var ind = 0
    while ind < array.count {
        let num = array[ind]
        let correctIndex = num - 1

        if num > 0, correctIndex < array.count, array[correctIndex] != num {
            array.swapAt(ind, correctIndex)
        } else {
            ind += 1
        }
    }

    // Fase 2: encontrar o primeiro buraco
    for ind in 0..<array.count {
        if array[ind] != ind + 1 {
            return ind + 1
        }
    }

    return array.count + 1
}

// MARK: First submission
/*
 Uma vez passado nos testes, ao confirmar com a IA a solução está errada por usar o dicionário
 */
fileprivate func submission1(orderNumbers array: [Int]) -> Int {
    guard !array.isEmpty else { return 1 }
    
    var min = 0
    
    var cache = [Int: Bool]()
    
    for num in array {
        guard num > 0 else { continue }
        
        defer { cache[num] = true }
        
        if min == 0 {
            min = num
        }
        
        if num < min {
            min = num
        }
    }
    
    if min != 1 {
        return 1
    }
    
    repeat {
        min += 1
    } while cache[min] != nil
    
    return min
}
