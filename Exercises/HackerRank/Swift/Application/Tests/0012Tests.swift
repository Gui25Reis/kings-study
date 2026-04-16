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
        // head=[1,2,2,2,3,4,4,5]
        let expected = "[1, 2, 3, 4, 5]"
        inputs = ["8", "1", "2", "2", "2", "3", "4", "4", "5"]
        validate(expected: expected)
    }

    func test_02() {
        // head=[] — lista vazia
        let expected = "[]"
        inputs = ["0"]
        validate(expected: expected)
    }

    func test_03() {
        // head=[1] — unico elemento
        let expected = "[1]"
        inputs = ["1", "1"]
        validate(expected: expected)
    }

    /* Additional tests */
    func test_04() {
        // head=[1,1,1,1] — todos iguais
        let expected = "[1]"
        inputs = ["4", "1", "1", "1", "1"]
        validate(expected: expected)
    }

    func test_05() {
        // head=[1,2,3,4,5] — sem duplicatas
        let expected = "[1, 2, 3, 4, 5]"
        inputs = ["5", "1", "2", "3", "4", "5"]
        validate(expected: expected)
    }

    func test_06() {
        // head=[1,1,2,2,3,3] — pares de duplicatas
        let expected = "[1, 2, 3]"
        inputs = ["6", "1", "1", "2", "2", "3", "3"]
        validate(expected: expected)
    }

    func test_07() {
        // head=[-3,-3,-1,0,0,2] — valores negativos com duplicatas
        let expected = "[-3, -1, 0, 2]"
        inputs = ["6", "-3", "-3", "-1", "0", "0", "2"]
        validate(expected: expected)
    }

    func test_08() {
        // head=[1,1] — dois elementos iguais
        let expected = "[1]"
        inputs = ["2", "1", "1"]
        validate(expected: expected)
    }
}
