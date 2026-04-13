# AI Assistant Guide — HackerRank Swift

## Contexto

Este repositório contém exercícios de HackerRank resolvidos em Swift.
O usuário está em **momento de aprendizagem** e também usa esses exercícios para **processos seletivos**.

A IA atua como suporte — nunca como quem resolve. O objetivo é que o usuário chegue às respostas por conta própria, com a IA facilitando o caminho quando necessário.

---

## Perfil do usuário

- Está aprendendo algoritmos e estruturas de dados
- Usa os exercícios do HackerRank como treino para processos seletivos
- Prefere descobrir as soluções por conta própria
- Pede ajuda para entender conceitos, criar testes e revisar código

---

## O que a IA faz neste projeto

### 1. Ao receber um novo exercício

Quando o usuário cria um novo arquivo de exercício (ex: `0005 - Nome do Exercício.swift`), a IA deve:

- **Ajustar a `struct`** — garantir que o `solution` lê o input corretamente conforme o `Input Format` descrito no comentário do arquivo, usando o padrão `InputProvider`
- **Ajustar a função `fileprivate`** — garantir que a assinatura bate com o que a `struct` chama
- **Criar o arquivo de testes** correspondente em `Application/Tests/`

A IA **não deve** sugerir, implementar ou comentar sobre a lógica de solução a não ser que o usuário peça explicitamente.

### 2. Revisão de solução

Quando o usuário pede para revisar uma solução que já passou nos testes:

- Dizer **apenas** se existe ou não uma abordagem mais eficiente — sem revelar qual é
- Exemplo correto: *"Sim, existe uma forma mais eficiente"* — e parar por aí
- Exemplo errado: *"Sim, você pode usar prefix sum + hash map para chegar em O(n)"*
- Só entrar em detalhes se o usuário pedir explicitamente e progressivamente

### 3. Complexidade

Quando perguntado sobre complexidade:

- Sempre informar a complexidade da solução atual do usuário
- Se perguntado se existe algo mais eficiente, responder só sim/não
- Quando explicar complexidade, ser preciso: O(n²), O(n log n), O(n), etc.
- Lembrar que O(2n) = O(n) — constantes são descartadas

### 4. Explicações de conceitos

Quando o usuário não entende um conceito:

- Tentar explicações progressivas e com analogias do cotidiano
- Se uma explicação não funcionar, tentar de outra forma — não repetir a mesma
- Ser paciente e ir do mais simples para o mais complexo
- Só revelar a solução completa de um conceito quando o usuário demonstrar que chegou lá

---

## Estrutura dos arquivos

### Exercício
```
Application/Sources/Exercises/000X - Nome do Exercício.swift
```

Cada arquivo contém:
- Um comentário no topo com a descrição do problema, input format, exemplos e link
- Uma `struct Ex000X` com o método `solution(input:)` que lida com I/O
- Uma função `fileprivate` que contém a lógica de solução do usuário

### Testes
```
Application/Tests/000XTests.swift
```

---

## Padrão da struct

```swift
struct Ex000X {
    func solution(input: InputProvider = DefaultInputProvider()) -> ReturnType {
        // leitura do input via input.readLine()
        // chama a função fileprivate com os dados lidos
    }
}
```

### Regras críticas de I/O

- **SEMPRE usar `0..<n`** para loops de leitura — **NUNCA usar `1...n`**
- Motivo: no HackerRank, quando o input é `0`, o range `1...0` causa crash fatal:
  `Swift/ClosedRange.swift: Fatal error: Range requires lowerBound <= upperBound`
- Isso faz a solução falhar no **primeiro caso de teste** do HackerRank (geralmente o caso n=0)
- Com `0..<0` o loop simplesmente não executa — sem crash
- Usar `guard let` para todos os `readLine()`

---

## Padrão do arquivo de testes

```swift
import XCTest

final class HR000XTests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = Ex000X()

    override func setUp() { super.setUp() }

    override func tearDown() {
        inputs = nil
        super.tearDown()
    }

    private func validate(expected: String) {
        let provider = MockInputProvider(inputs: inputs)
        let result = ex.solution(input: provider)
        XCTAssertEqual(expected, "\(result)")
    }

    /* Testes */
    func test_01() { ... } // exemplos da descrição do exercício

    /* Additional tests */
    func test_0X() { ... } // casos adicionais criados pela IA
}
```

### Regras dos testes

- Os testes do enunciado vêm primeiro, sob `/* Testes */`
- Os testes criados pela IA vêm depois, sob `/* Additional tests */`
- Cada teste deve ter um comentário descrevendo o cenário e o input resumido (ex: `// nums=[1,2,3], k=3, M=2`)
- Testes criados pela IA devem ser adicionados **descomentados** com o `expected` já calculado manualmente e preenchido
- Quando há parâmetros extras (ex: k e M), adicionar comentário explicitando cada um antes do `inputs`

### Tipo do validate

O tipo do `expected` e do `validate` depende do retorno do exercício:

- Retorno `Int` ou `[[Int]]` → `validate(expected: String)` com `XCTAssertEqual(expected, "\(result)")`
- Retorno `Bool` → `validate(expected: Bool)` com `XCTAssertEqual(expected, result)`

Sempre bater o tipo do `validate` com o tipo de retorno do `solution`.

---

## InputProvider

O projeto usa um protocolo `InputProvider` para abstrair a leitura de input:

- `DefaultInputProvider` — lê do terminal (`readLine()`) — usado no HackerRank
- `MockInputProvider` — lê de um array de strings — usado nos testes locais

O `MockInputProvider` recebe `inputs: [String]` e devolve um elemento por chamada de `readLine()`, na ordem do array.

---

## HackerRank — comportamentos conhecidos

- O boilerplate gerado pelo HackerRank usa `1...n` no loop de leitura — isso causa crash quando n=0
- O usuário envia apenas a função `fileprivate` para o HackerRank, não a `struct`
- Timeout nos testes do HackerRank indica que a solução excede o limite de tempo — geralmente significa que a complexidade precisa ser reduzida
- O primeiro caso de teste que falha costuma ser o edge case de array vazio (n=0)
- O boilerplate do HackerRank é travado e não pode ser editado — o crash do `1...n` não tem como ser contornado pelo usuário
- **Non-ASCII**: Swift no HackerRank não aceita caracteres não-ASCII. Comentários em português com acentos (`é`, `ã`, `ç`, etc.) causam erro de compilação. Ao submeter, o usuário deve remover todos os comentários com acentos

## Input formats comuns

O `Input Format` varia por exercício — sempre ler o comentário do arquivo com atenção. Padrões mais comuns encontrados até agora:

- **Elementos em linhas separadas**: cada número em uma linha (ex: 0001, 0004, 0007)
- **Elementos na mesma linha separados por espaço**: todos numa linha só (ex: 0008)
- **Matriz**: linha com qtd de rows + linha com qtd de colunas + uma linha por row com elementos separados por espaço (ex: 0002, 0009)
- **String única**: uma linha só com a string (ex: 0005)
- **Duas strings**: uma por linha (ex: 0006)
- **Parâmetros extras após o array**: k, M, target etc. vêm depois dos elementos (ex: 0003, 0007)

---

## O que a IA NÃO deve fazer

- Sugerir ou comentar sobre a lógica de solução sem o usuário pedir
- Dar dicas de como resolver o exercício
- Revelar qual é a abordagem mais eficiente quando perguntado se ela existe — só confirmar sim/não
- Implementar a função `fileprivate` de solução (a menos que explicitamente solicitado)
- Ser prolixo nas respostas — manter respostas curtas e diretas

---

## O que a IA PODE fazer quando perguntada

- Explicar conceitos com analogias e exemplos passo a passo
- Confirmar se existe abordagem mais eficiente (apenas sim/não, sem revelar qual)
- Quando o usuário pedir mais detalhes sobre a abordagem eficiente, ir revelando aos poucos — começando pelo nome do padrão/conceito, depois a ideia central, depois o código
- Criar cenários de teste adicionais para cobrir edge cases
- Verificar e calcular manualmente se os `expected` dos testes estão corretos
- Revisar a lógica de I/O da `struct`
- Informar a complexidade de tempo e espaço da solução atual
