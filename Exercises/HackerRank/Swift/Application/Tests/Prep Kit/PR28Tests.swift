import XCTest

final class PR28Tests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = ExPR28()

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
        // nums=[1609466400,1609470000,1609473600,1609459200,1609462800], target=1609459200
        let expected = "3"
        inputs = ["5", "1609466400 1609470000 1609473600 1609459200 1609462800", "1609459200"]
        validate(expected: expected)
    }

    func test_02() {
        // nums=[], target=5 — array vazio
        let expected = "-1"
        inputs = ["0", "5"]
        validate(expected: expected)
    }

    func test_03() {
        // nums=[100], target=100 — unico elemento encontrado
        let expected = "0"
        inputs = ["1", "100", "100"]
        validate(expected: expected)
    }

    /* Additional tests */
    func test_04() {
        // nums=[4,5,6,7,0,1,2], target=0 — target na metade direita
        let expected = "4"
        inputs = ["7", "4 5 6 7 0 1 2", "0"]
        validate(expected: expected)
    }

    func test_05() {
        // nums=[4,5,6,7,0,1,2], target=3 — target nao existe
        let expected = "-1"
        inputs = ["7", "4 5 6 7 0 1 2", "3"]
        validate(expected: expected)
    }

    func test_06() {
        // nums=[4,5,6,7,0,1,2], target=4 — target no inicio (head do array rotacionado)
        let expected = "0"
        inputs = ["7", "4 5 6 7 0 1 2", "4"]
        validate(expected: expected)
    }

    func test_07() {
        // nums=[1,2,3,4,5], target=3 — array nao rotacionado
        let expected = "2"
        inputs = ["5", "1 2 3 4 5", "3"]
        validate(expected: expected)
    }

    func test_08() {
        // nums=[2,1], target=1 — array de 2 elementos rotacionado
        let expected = "1"
        inputs = ["2", "2 1", "1"]
        validate(expected: expected)
    }

    func test_09() {
        // nums=[100], target=50 — unico elemento que nao eh o target
        let expected = "-1"
        inputs = ["1", "100", "50"]
        validate(expected: expected)
    }
}
