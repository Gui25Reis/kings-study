//
//  Gui Reis  -  gui.sreis25@gmail.com - 23/04/24
//

/**
 ![Imagem](https://resources.beecrowd.com/gallery/images/problems/UOJ_1028.jpg)
 
 Ricardo e Vicente são aficionados por figurinhas. Nas horas vagas, eles arrumam um jeito de jogar um “bafo” ou algum outro jogo que envolva tais figurinhas. Ambos também têm o hábito de trocarem as figuras repetidas com seus amigos e certo dia pensaram em uma brincadeira diferente. Chamaram todos os amigos e propuseram o seguinte: com as figurinhas em mãos, cada um tentava fazer uma troca com o amigo que estava mais perto seguindo a seguinte regra: cada um contava quantas figurinhas tinha. Em seguida, eles tinham que dividir as figurinhas de cada um em pilhas do mesmo tamanho, no maior tamanho que fosse possível para ambos. Então, cada um escolhia uma das pilhas de figurinhas do amigo para receber. Por exemplo, se Ricardo e Vicente fossem trocar as figurinhas e tivessem respectivamente 8 e 12 figuras, ambos dividiam todas as suas figuras em pilhas de 4 figuras (Ricardo teria 2 pilhas e Vicente teria 3 pilhas) e ambos escolhiam uma pilha do amigo para receber.
 
 Entrada
 A primeira linha da entrada contém um único inteiro N (1 ≤ N ≤ 3000), indicando o número de casos de teste. Cada caso de teste contém 2 inteiros F1 (1 ≤ F1 ≤ 1000) e F2 (1 ≤ F2 ≤ 1000) indicando, respectivamente, a quantidade de figurinhas que Ricardo e Vicente têm para trocar.

 Saída
 Para cada caso de teste de entrada haverá um valor na saída, representando o tamanho máximo da pilha de figurinhas que poderia ser trocada entre dois jogadores.
 
 
 link: https://judge.beecrowd.com/pt/problems/view/1028
 */


// MARK: - Exercício

import Foundation

fileprivate enum NumberTypes {
    case even
    case odd
    case mix
}


fileprivate func findTypeOf(a numA: Int, b numB: Int) -> NumberTypes {
    let aIsEven = numA.isMultiple(of: 2)
    let bIsEven = numB.isMultiple(of: 2)
    
    if aIsEven && bIsEven {
        return .even
    } else if !aIsEven && !bIsEven {
        return .odd
    } else {
        return .mix
    }
}

fileprivate func checkIfIsMultiple(numA: Int, numB: Int) -> Int? {
    return numA.isBigger(then: numB)
    ? numA.isDivisible(by: numB) ? numB : nil
    : numB.isDivisible(by: numA) ? numA : nil
}

fileprivate func prepareInitialData(numA: Int, numB: Int) -> (starter: Int, jump: Int) {
    let type = findTypeOf(a: numA, b: numB)
    switch type {
    case .even:
        return (2, 2)
    case .odd:
        return (3, 2)
    case .mix:
        return (2, 1)
    }
}

fileprivate func factorIfPossible(numA: Int, numB: Int, times: Int = 0) -> (numA: Int, numB: Int, times: Int) {
    
    var resultA = numA.quotientAndRemainder(dividingBy: 2)
    var resultB = numB.quotientAndRemainder(dividingBy: 2)
    
    while resultA.remainder.isZero && resultB.remainder.isZero {
        
        return (resultA.quotient, resultB.quotient, times: times)
    }
    
    return (0, 0, 0)
}

fileprivate func mmc(_ figA: Int, _ figB: Int) -> Int? {
    let (starter, jump) = prepareInitialData(numA: figA, numB: figB)
    var number = starter
    
    var aIsMultiple = figA.isMultiple(of: number)
    var bIsMultiple = figB.isMultiple(of: number)
    
    while !aIsMultiple || !bIsMultiple {
        number += jump
        
        if number.isBigger(then: figA) || number.isBigger(then: figB) {
            return nil
        }
        
        aIsMultiple = figA.isMultiple(of: number)
        bIsMultiple = figB.isMultiple(of: number)
    }
    
    return number
}

fileprivate func findMMC(_ figA: Int, _ figB: Int) -> String {
    var number = 2
    
    var aIsMultiple = figA.isMultiple(of: number)
    var bIsMultiple = figB.isMultiple(of: number)
    
    while !aIsMultiple || !bIsMultiple {
        number += 1
        
        aIsMultiple = figA.isMultiple(of: number)
        bIsMultiple = figB.isMultiple(of: number)
    }
    
    let resultA = figA/number
    let resultB = figB/number
    
    let aIsBigger = resultA > resultB
    return aIsBigger
    ? "\(resultA)"
    : "\(resultB)"
}

func ex1028(input: InputProvider = DefaultInputProvider()) {
    input.shouldConsidereNextLineForEachPrint = true
    
    let entriesCount = input.readLine()!
    
    for _ in 0..<entriesCount.int {
        let userInput = input.readLine()!
        
        let entries = userInput.split()
        let (figA, figB) = (entries[0].int, entries[1].int)
        
        let response = findMMC(figA, figB)
        input.print(response)
    }
}


// ex1028()
