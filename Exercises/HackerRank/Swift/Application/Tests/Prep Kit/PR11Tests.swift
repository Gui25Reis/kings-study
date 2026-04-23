import XCTest

final class PR11Tests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = ExPR11()

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
        // prices=[1,2,3,4,5], budget=7
        let expected = "8"
        inputs = ["5", "7", "1 2 3 4 5"]
        validate(expected: expected)
    }

    func test_02() {
        // prices=[], budget=100 — lista vazia
        let expected = "0"
        inputs = ["0", "100"]
        validate(expected: expected)
    }

    func test_03() {
        // prices=[5], budget=5 — unico elemento, nao forma par
        let expected = "0"
        inputs = ["1", "5", "5"]
        validate(expected: expected)
    }

    /* Additional tests */
    func test_04() {
        // prices=[1,2], budget=3 — unico par valido (1+2=3)
        let expected = "1"
        inputs = ["2", "3", "1 2"]
        validate(expected: expected)
    }

    func test_05() {
        // prices=[1,2], budget=2 — nenhum par valido (1+2=3 > 2)
        let expected = "0"
        inputs = ["2", "2", "1 2"]
        validate(expected: expected)
    }

    func test_06() {
        // prices=[1,1,1,1], budget=2 — todos os pares validos (4 pares)
        let expected = "6"
        inputs = ["4", "2", "1 1 1 1"]
        validate(expected: expected)
    }

    func test_07() {
        // prices=[1,2,3,4,5], budget=100 — todos os pares validos (10 pares)
        let expected = "10"
        inputs = ["5", "100", "1 2 3 4 5"]
        validate(expected: expected)
    }

    func test_08() {
        // prices=[5,5,5], budget=9 — nenhum par valido (5+5=10 > 9)
        let expected = "0"
        inputs = ["3", "9", "5 5 5"]
        validate(expected: expected)
    }
}
