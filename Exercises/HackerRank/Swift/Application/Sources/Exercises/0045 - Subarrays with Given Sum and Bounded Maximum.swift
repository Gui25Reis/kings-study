/*
 Subarrays with Given Sum and Bounded Maximum
 Given an integer array nums and integers k and M, count the number of contiguous subarrays whose sum equals k and whose maximum element is at most M.

 Example

 Input

 nums = [2, -1, 2, 1, -2, 3]
 k = 3
 M = 2
 Output

 2
 Explanation

 We need subarrays with sum = 3 and all elements ≤ 2.
 Also, any subarray containing 3 is invalid because 3 > M. Check all starts:

 - From index 0: [2, -1, 2] → sum = 3, max = 2 → valid (count = 1).
 - From index 2: [2, 1] → sum = 3, max = 2 → valid (count = 2). No other subarray qualifies. Thus the total count is 2.
 Input Format

 The first line contains an integer n denoting the number of elements in nums.
 The next n lines contains an integer denoting elements in nums followed by the value of k & M.
 Example

 6 → number of elements in nums
 2 → elements of nums
 -1
 2
 1
 -2
 3
 3 → value of k
 2 → value of M
 Constraints

 0 <= nums.length <= 1000000
 -10^9 <= nums[i] <= 10^9 for all 0 <= i < nums.length
 -10^15 <= k <= 10^15
 -10^9 <= M <= 10^9
 Output Format

 Returns a non-negative integer denoting the count of all contiguous subarrays of nums.
 
 Link:
 https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/subarrays-given-sum-bounded-maximum
 */

struct Ex0045 {
    func solution(input: InputProvider = DefaultInputProvider()) -> Int {
        guard let qtdInput = input.readLine(), let qtd = Int(qtdInput)
        else { return 0 }

        lazy var array = [Int]()
        for _ in 0..<qtd {
            guard let dataInput = input.readLine(), let number = Int(dataInput)
            else { continue }

            array.append(number)
        }

        guard let kInput = input.readLine(), let k = Int(kInput),
              let mInput = input.readLine(), let m = Int(mInput)
        else { return 0 }

        return countSubarraysWithSumAndMaxAtMost(nums: array, k: k, M: m)
    }
}

fileprivate func countSubarraysWithSumAndMaxAtMost(nums: [Int], k target: Int, M max: Int) -> Int {
    lazy var result = 0
    
    for start in 0..<nums.count {
        let numberStart = nums[start]
        guard numberStart <= max else { continue }
        
        if numberStart == target {
            result += 1
        }
        
        var count = numberStart
        
        let nextIndex = start+1
        for ind in nextIndex..<nums.count {
            let number = nums[ind]
            guard number <= max else { break }
            
            count += number
            
            if count == target {
                result += 1
            }
        }
    }
    
    return result
}

// MARK: - Solução com AI
fileprivate func aiSolution(nums: [Int], k target: Int, M max: Int) -> Int {
    // Ideia: prefix sum + hash map
    //
    // Se prefixSum[j] - prefixSum[i] == k, então o subarray nums[i..<j] tem soma k.
    // Traduzindo: prefixSum[i] == prefixSum[j] - k
    //
    // Percorremos o array uma vez, mantendo um dicionário de quantas vezes
    // cada prefix sum já apareceu. Quando um elemento > M é encontrado,
    // o dicionário é zerado — qualquer subarray que cruze esse ponto é inválido.
    //
    // Complexidade: O(n)

    var result = 0
    var prefixSum = 0
    var prefixCounts: [Int: Int] = [0: 1] // [prefixSum: quantidade de vezes que apareceu]

    for number in nums {
        if number > max {
            // Zera tudo: subarrays não podem cruzar esse elemento
            prefixSum = 0
            prefixCounts = [0: 1]
            continue
        }

        prefixSum += number
        result += prefixCounts[prefixSum - target, default: 0]
        prefixCounts[prefixSum, default: 0] += 1
    }

    return result
}

/*
 ══════════════════════════════════════════════════
 EXPLICAÇÃO COMPLETA — Prefix Sum + Hash Map
 ══════════════════════════════════════════════════

 ── O QUE É PREFIX SUM? ──────────────────────────

 Prefix sum é um array onde cada posição guarda a soma acumulada até ali.

 nums:       2  -1   2   1
 prefixSum:  2   1   3   4
             ↑   ↑   ↑   ↑
             2  2-1  1+2  3+1

 Pensa como uma conta bancária: a cada dia você deposita um valor,
 e o prefixSum é o saldo no fim daquele dia.

 ── A PROPRIEDADE CENTRAL ────────────────────────

 A soma de qualquer subarray entre i e j é:

     soma(i..j) = prefixSum[j] - prefixSum[i-1]

 Exemplo: soma de [-1, 2] (índices 1..2):
     prefixSum[2] - prefixSum[0] = 3 - 2 = 1

 Isso funciona porque prefixSum[i-1] "embutia" tudo que veio antes.
 Subtraindo, esse histórico se cancela e sobra só o período que queremos.
 É como saber o saldo no fim do dia 3 e no fim do dia 1 —
 a diferença é exatamente o que foi depositado nos dias 2 e 3.

 ── A SACADA DO HASH MAP ─────────────────────────

 Queremos: soma(i..j) == k
 Traduzindo com a fórmula acima:
     prefixSum[j] - prefixSum[i-1] == k
     prefixSum[i-1] == prefixSum[j] - k

 Ou seja: ao chegar em j, basta saber quantas vezes
 o valor (prefixSum[j] - k) já apareceu antes.
 Cada ocorrência é um subarray válido terminando em j.

 O hash map guarda: { saldo_acumulado: quantas_vezes_apareceu }
 Assim a consulta é feita em O(1), sem precisar voltar atrás no array.

 ── POR QUE COMEÇAR COM {0: 1}? ──────────────────

 O saldo antes do índice 0 é 0 (nenhum depósito ainda).
 Sem esse valor inicial, subarrays que começam do índice 0 nunca seriam encontrados,
 pois não haveria nenhum prefixSum[i-1] registrado para comparar.

 ── POR QUE RESETAR QUANDO number > M? ───────────

 Qualquer subarray que contenha um elemento > M é inválido.
 Ao resetar prefixSum=0 e prefixCounts={0:1}, apagamos o histórico —
 garantindo que nenhum subarray futuro "enxergue" o período anterior ao elemento inválido.

 ── COMPLEXIDADE ─────────────────────────────────

 O(n) — percorre o array uma única vez.
 Cada elemento faz uma consulta e uma inserção no hash map, ambas O(1).

 ══════════════════════════════════════════════════
 TRACE — test_01: nums=[2,-1,2,1,-2,3], k=3, M=2
 ══════════════════════════════════════════════════

 estado inicial → prefixSum=0, counts={0:1}, result=0

 number=2  (2<=2 ✓) → prefixSum=2, busca[2-3=-1]=0, result=0, counts={0:1, 2:1}
 number=-1 (-1<=2 ✓) → prefixSum=1, busca[1-3=-2]=0, result=0, counts={0:1, 2:1, 1:1}
 number=2  (2<=2 ✓) → prefixSum=3, busca[3-3=0]=1,  result=1, counts={0:1, 2:1, 1:1, 3:1}
   → encontrou! prefixSum[i-1]=0 existia → subarray [2,-1,2] tem soma 3
 number=1  (1<=2 ✓) → prefixSum=4, busca[4-3=1]=1,  result=2, counts={0:1, 2:1, 1:1, 3:1, 4:1}
   → encontrou! prefixSum[i-1]=1 existia → subarray [2,1] tem soma 3
 number=-2 (-2<=2 ✓) → prefixSum=2, busca[2-3=-1]=0, result=2, counts={0:1, 2:2, 1:1, 3:1, 4:1}
 number=3  (3>2  ✗) → RESET: prefixSum=0, counts={0:1}

 resultado → 2 ✓

 ══════════════════════════════════════════════════
 TRACE — test_05: nums=[1,2,3,-1,4,-2,2], k=4, M=3
 ══════════════════════════════════════════════════

 estado inicial → prefixSum=0, counts={0:1}, result=0

 number=1  (1<=3 ✓) → prefixSum=1, busca[1-4=-3]=0, result=0, counts={0:1, 1:1}
 number=2  (2<=3 ✓) → prefixSum=3, busca[3-4=-1]=0, result=0, counts={0:1, 1:1, 3:1}
 number=3  (3<=3 ✓) → prefixSum=6, busca[6-4=2]=0,  result=0, counts={0:1, 1:1, 3:1, 6:1}
 number=-1 (-1<=3 ✓) → prefixSum=5, busca[5-4=1]=1, result=1, counts={0:1, 1:1, 3:1, 6:1, 5:1}
   → encontrou! prefixSum[i-1]=1 existia → subarray [2,3,-1] tem soma 4
 number=4  (4>3  ✗) → RESET: prefixSum=0, counts={0:1}
 number=-2 (-2<=3 ✓) → prefixSum=-2, busca[-2-4=-6]=0, result=1, counts={0:1, -2:1}
 number=2  (2<=3 ✓) → prefixSum=0,  busca[0-4=-4]=0,  result=1, counts={0:2, -2:1}

 resultado → 1 ✓
 */
