import XCTest

final class HR0012Tests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = Ex0012()

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
        // head=[5,6,7,8], k=3 — remove posicao 3 do fim (0-indexed) = head (5)
        let expected = "[6, 7, 8]"
        inputs = ["4", "5", "6", "7", "8", "3"]
        validate(expected: expected)
    }

    func test_02() {
        // head=[5], k=1 — k invalido (>= n), retorna lista original
        let expected = "[5]"
        inputs = ["1", "5", "1"]
        validate(expected: expected)
    }

    func test_03() {
        // head=[1,2], k=0 — remove ultimo (2)
        let expected = "[1]"
        inputs = ["2", "1", "2", "0"]
        validate(expected: expected)
    }

    /* Additional tests */
    func test_04() {
        // head=[1,2,3,4,5], k=2 — remove posicao 2 do fim (3)
        let expected = "[1, 2, 4, 5]"
        inputs = ["5", "1", "2", "3", "4", "5", "2"]
        validate(expected: expected)
    }

    func test_05() {
        // head=[1,2,3], k=0 — remove ultimo (3)
        let expected = "[1, 2]"
        inputs = ["3", "1", "2", "3", "0"]
        validate(expected: expected)
    }

    func test_06() {
        // head=[7], k=0 — remove unico elemento
        let expected = "[]"
        inputs = ["1", "7", "0"]
        validate(expected: expected)
    }

    func test_07() {
        // head=[], k=0 — lista vazia
        let expected = "[]"
        inputs = ["0", "0"]
        validate(expected: expected)
    }

    func test_08() {
        // head=[1,2,3,4,5], k=4 — remove head (1)
        let expected = "[2, 3, 4, 5]"
        inputs = ["5", "1", "2", "3", "4", "5", "4"]
        validate(expected: expected)
    }
}
