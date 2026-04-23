import XCTest

final class PR23Tests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = ExPR23()

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
        // n=7, arvore balanceada: height=3
        // values=[4,2,6,1,3,5,7], left=[1,3,5,-1,-1,-1,-1], right=[2,4,6,-1,-1,-1,-1]
        let expected = "3"
        inputs = [
            "7", "4", "2", "6", "1", "3", "5", "7",
            "7", "1", "3", "5", "-1", "-1", "-1", "-1",
            "7", "2", "4", "6", "-1", "-1", "-1", "-1"
        ]
        validate(expected: expected)
    }

    func test_02() {
        // n=1, unico no: height=1
        // values=[10], left=[-1], right=[-1]
        let expected = "1"
        inputs = ["1", "10", "1", "-1", "1", "-1"]
        validate(expected: expected)
    }

    func test_03() {
        // n=2, raiz com filho esquerdo: height=2
        // values=[5,3], left=[1,-1], right=[-1,-1]
        let expected = "2"
        inputs = ["2", "5", "3", "2", "1", "-1", "2", "-1", "-1"]
        validate(expected: expected)
    }

    /* Additional tests */
    func test_04() {
        // n=0, arvore vazia: height=0
        let expected = "0"
        inputs = ["0", "0", "0"]
        validate(expected: expected)
    }

    func test_05() {
        // arvore degenerada (lista): apenas filhos direitos — height=4
        // values=[1,2,3,4], left=[-1,-1,-1,-1], right=[1,2,3,-1]
        let expected = "4"
        inputs = [
            "4", "1", "2", "3", "4",
            "4", "-1", "-1", "-1", "-1",
            "4", "1", "2", "3", "-1"
        ]
        validate(expected: expected)
    }

    func test_06() {
        // arvore com ramo esquerdo mais longo: height=3
        // values=[5,3,7,1], left=[1,3,-1,-1], right=[2,-1,-1,-1]
        let expected = "3"
        inputs = [
            "4", "5", "3", "7", "1",
            "4", "1", "3", "-1", "-1",
            "4", "2", "-1", "-1", "-1"
        ]
        validate(expected: expected)
    }
}
