import XCTest

final class HR0006Tests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = Ex0006()

    /* Ciclo de Vida */
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        inputs = nil
        super.tearDown()
    }


    /* Aux */
    private func validate(expected: Bool) {
        // Prepare
        let provider = MockInputProvider(inputs: inputs)

        // Action
        let result = ex.solution(input: provider)

        // Validation
        XCTAssertEqual(expected, result)
    }


    /* Testes */
    func test_01() {
        // Prepare
        // s1="abcde", s2="cdeab"
        let expected = true
        inputs = ["abcde", "cdeab"]

        // Action
        validate(expected: expected)
    }

    func test_02() {
        // Prepare - sample 0: identicas, nao eh rotacao nao-trivial
        // s1="a", s2="a"
        let expected = false
        inputs = ["a", "a"]

        // Action
        validate(expected: expected)
    }

    func test_03() {
        // Prepare - sample 1: letras diferentes, nao eh rotacao
        // s1="a", s2="b"
        let expected = false
        inputs = ["a", "b"]

        // Action
        validate(expected: expected)
    }

    /* Additional tests */
    func test_04() {
        // Prepare - strings identicas com mais de um char
        // s1="abc", s2="abc"
        let expected = false
        inputs = ["abc", "abc"]

        // Action
        validate(expected: expected)
    }

    func test_05() {
        // Prepare - rotacao de um unico passo
        // s1="abcd", s2="bcda"
        let expected = true
        inputs = ["abcd", "bcda"]

        // Action
        validate(expected: expected)
    }

    func test_06() {
        // Prepare - nao eh rotacao, mesmas letras mas ordem errada
        // s1="abcd", s2="abdc"
        let expected = false
        inputs = ["abcd", "abdc"]

        // Action
        validate(expected: expected)
    }

    func test_07() {
        // Prepare - rotacao pelo ultimo elemento
        // s1="abcd", s2="dabc"
        let expected = true
        inputs = ["abcd", "dabc"]

        // Action
        validate(expected: expected)
    }

    func test_08() {
        // Prepare - string com chars repetidos, rotacao valida
        // s1="aab", s2="baa"
        let expected = true
        inputs = ["aab", "baa"]

        // Action
        validate(expected: expected)
    }

    func test_09() {
        // Prepare - string com chars repetidos, identica
        // s1="aaa", s2="aaa"
        let expected = false
        inputs = ["aaa", "aaa"]

        // Action
        validate(expected: expected)
    }

    func test_10() {
        // Prepare - primeira letra de s2 aparece multiplas vezes em s1
        // a primeira ocorrencia nao forma rotacao, mas a segunda sim
        // s1="aab", s2="aba"
        let expected = true
        inputs = ["aab", "aba"]

        // Action
        validate(expected: expected)
    }
}
