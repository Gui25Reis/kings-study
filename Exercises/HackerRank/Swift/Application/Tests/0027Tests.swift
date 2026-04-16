import XCTest

final class HR0027Tests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = Ex0027()

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
        // arr=[8,1,-1,0,3,6,2,4,5,7,9], k=2 — sequencia [-1,1,3,5,7,9], length=6
        let expected = "6"
        inputs = ["11", "8", "1", "-1", "0", "3", "6", "2", "4", "5", "7", "9", "2"]
        validate(expected: expected)
    }

    func test_02() {
        // arr=[], k=5 — array vazio
        let expected = "0"
        inputs = ["0", "5"]
        validate(expected: expected)
    }

    func test_03() {
        // arr=[42], k=7 — unico elemento, sequencia de tamanho 1
        let expected = "1"
        inputs = ["1", "42", "7"]
        validate(expected: expected)
    }

    /* Additional tests */
    func test_04() {
        // arr=[1,2,3,4,5], k=1 — sequencia completa [1,2,3,4,5], length=5
        let expected = "5"
        inputs = ["5", "1", "2", "3", "4", "5", "1"]
        validate(expected: expected)
    }

    func test_05() {
        // arr=[1,3,5,7,9], k=2 — sequencia completa, length=5
        let expected = "5"
        inputs = ["5", "1", "3", "5", "7", "9", "2"]
        validate(expected: expected)
    }

    func test_06() {
        // arr=[1,2,3,4,5], k=10 — nenhum par difere por 10, maior sequencia tem length=1
        let expected = "1"
        inputs = ["5", "1", "2", "3", "4", "5", "10"]
        validate(expected: expected)
    }

    func test_07() {
        // arr=[1,1,1,3,3,5], k=2 — duplicatas ignoradas, sequencia unica [1,3,5], length=3
        let expected = "3"
        inputs = ["6", "1", "1", "1", "3", "3", "5", "2"]
        validate(expected: expected)
    }
}
