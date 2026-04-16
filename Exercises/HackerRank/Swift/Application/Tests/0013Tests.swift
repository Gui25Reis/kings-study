import XCTest

final class HR0013Tests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = Ex0013()

    override func setUp() { super.setUp() }

    override func tearDown() {
        inputs = nil
        super.tearDown()
    }


    /* Aux */
    private func validate(expected: String) {
        let provider = MockInputProvider(inputs: inputs)
        let result = ex.solution(input: provider)
        XCTAssertEqual(expected, "\(result)")
    }


    /* Testes */
    func test_01() {
        // n=1 — unico par possivel
        let expected = "[\"<>\"]"
        inputs = ["1"]
        validate(expected: expected)
    }

    func test_02() {
        // n=2 — dois pares, duas combinacoes validas
        let expected = "[\"<<>>\", \"<><>\"]"
        inputs = ["2"]
        validate(expected: expected)
    }

    func test_03() {
        // n=3 — cinco combinacoes validas
        let expected = "[\"<<<>>>\", \"<<><>>\", \"<<>><>\", \"<><<>>\", \"<><><>\"]"
        inputs = ["3"]
        validate(expected: expected)
    }

    /* Additional tests */
    func test_04() {
        // n=0 — nenhum par
        let expected = "[]"
        inputs = ["0"]
        validate(expected: expected)
    }
}
