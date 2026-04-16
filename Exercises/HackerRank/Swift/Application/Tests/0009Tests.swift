import XCTest

final class HR0009Tests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = Ex0009()

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
        // operations=['push 2','push 0','push 3','push 0','getMin','pop','getMin','pop','top','getMin']
        let expected = "[0, 0, 0, 0]"
        inputs = ["10", "push 2", "push 0", "push 3", "push 0", "getMin", "pop", "getMin", "pop", "top", "getMin"]
        validate(expected: expected)
    }

    func test_02() {
        // operations=['push 5','getMin']
        let expected = "[5]"
        inputs = ["2", "push 5", "getMin"]
        validate(expected: expected)
    }

    func test_03() {
        // operations=['push 0','top']
        let expected = "[0]"
        inputs = ["2", "push 0", "top"]
        validate(expected: expected)
    }

    /* Additional tests */
    func test_04() {
        // push crescente, min deve ser sempre o primeiro
        // operations=['push 1','push 2','push 3','getMin']
        let expected = "[1]"
        inputs = ["4", "push 1", "push 2", "push 3", "getMin"]
        validate(expected: expected)
    }

    func test_05() {
        // push decrescente, min deve ser sempre o ultimo empilhado
        // operations=['push 3','push 2','push 1','getMin']
        let expected = "[1]"
        inputs = ["4", "push 3", "push 2", "push 1", "getMin"]
        validate(expected: expected)
    }

    func test_06() {
        // apos pop do minimo, getMin deve retornar o proximo menor
        // operations=['push 5','push 1','getMin','pop','getMin']
        let expected = "[1, 5]"
        inputs = ["5", "push 5", "push 1", "getMin", "pop", "getMin"]
        validate(expected: expected)
    }

    func test_07() {
        // top retorna o ultimo empilhado, nao o menor
        // operations=['push 3','push 1','push 4','top']
        let expected = "[4]"
        inputs = ["4", "push 3", "push 1", "push 4", "top"]
        validate(expected: expected)
    }

    func test_08() {
        // multiplos getMin e tops intercalados
        // operations=['push 2','push 2','getMin','top','pop','top']
        let expected = "[2, 2, 2]"
        inputs = ["6", "push 2", "push 2", "getMin", "top", "pop", "top"]
        validate(expected: expected)
    }
}
