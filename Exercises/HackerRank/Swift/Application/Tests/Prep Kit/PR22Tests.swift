import XCTest

final class PR22Tests: XCTestCase {

    var inputs: [String]!
    lazy var ex = ExPR22()

    override func setUp() {
        super.setUp()
        inputs = []
    }

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
        // n=4, links=[[0,1],[2,3]] — dois componentes separados
        let expected = "2"
        inputs = ["2", "2", "0 1", "2 3", "4"]
        validate(expected: expected)
    }

    func test_02() {
        // n=2, links=[[0,1]] — todos conectados
        let expected = "1"
        inputs = ["1", "2", "0 1", "2"]
        validate(expected: expected)
    }

    func test_03() {
        // n=3, links=[[0,1],[1,2],[0,2]] — triangulo, 1 componente
        let expected = "1"
        inputs = ["3", "2", "0 1", "1 2", "0 2", "3"]
        validate(expected: expected)
    }

    /* Additional tests */
    func test_04() {
        // n=4, sem links — cada nó é seu próprio componente
        let expected = "4"
        inputs = ["0", "2", "4"]
        validate(expected: expected)
    }

    func test_05() {
        // n=5, links=[[0,1],[2,3]] — componentes: {0,1}, {2,3}, {4}
        let expected = "3"
        inputs = ["2", "2", "0 1", "2 3", "5"]
        validate(expected: expected)
    }

    func test_06() {
        // n=1, sem links — unico nó isolado
        let expected = "1"
        inputs = ["0", "2", "1"]
        validate(expected: expected)
    }
}
