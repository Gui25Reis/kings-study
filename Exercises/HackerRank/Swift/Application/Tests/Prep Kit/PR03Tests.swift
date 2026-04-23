import XCTest

final class PR03Tests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = ExPR03()

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
        // code="A1b2B!a"
        let expected = true
        inputs = ["A1b2B!a"]

        // Action
        validate(expected: expected)
    }

    func test_02() {
        // Prepare - sample 0: único caractere
        // code="Z"
        let expected = true
        inputs = ["Z"]

        // Action
        validate(expected: expected)
    }

    func test_03() {
        // Prepare - sample 1: letras e dígitos, palindromo
        // code="abc123cba"
        let expected = true
        inputs = ["abc123cba"]

        // Action
        validate(expected: expected)
    }

    /* Additional tests */
    func test_04() {
        // Prepare - string vazia
        // code=""
        let expected = true
        inputs = [""]

        // Action
        validate(expected: expected)
    }

    func test_05() {
        // Prepare - só símbolos, nenhuma letra
        // code="123!@#"
        let expected = true
        inputs = ["123!@#"]

        // Action
        validate(expected: expected)
    }

    func test_06() {
        // Prepare - não é palíndromo
        // code="abc"
        let expected = false
        inputs = ["abc"]

        // Action
        validate(expected: expected)
    }

    func test_07() {
        // Prepare - case insensitive com símbolos no meio
        // code="A!b!a"
        let expected = true
        inputs = ["A!b!a"]

        // Action
        validate(expected: expected)
    }

    func test_08() {
        // Prepare - não é palíndromo com símbolos no meio
        // code="a!b!c"
        let expected = false
        inputs = ["a!b!c"]

        // Action
        validate(expected: expected)
    }
}
