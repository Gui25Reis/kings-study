import XCTest

final class HR0017Tests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = Ex0017()

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
        // taskDurations=[2,7,11,15], slotLength=9 — par (0,1): 2+7=9
        let expected = "[0, 1]"
        inputs = ["4", "2 7 11 15", "9"]
        validate(expected: expected)
    }

    func test_02() {
        // taskDurations=[1,2,3,4], slotLength=8 — nenhum par valido
        let expected = "[-1, -1]"
        inputs = ["4", "1 2 3 4", "8"]
        validate(expected: expected)
    }

    func test_03() {
        // taskDurations=[], slotLength=10 — lista vazia
        let expected = "[-1, -1]"
        inputs = ["0", "10"]
        validate(expected: expected)
    }

    func test_04() {
        // taskDurations=[5], slotLength=5 — unico elemento, nao forma par
        let expected = "[-1, -1]"
        inputs = ["1", "5", "5"]
        validate(expected: expected)
    }

    /* Additional tests */
    func test_05() {
        // taskDurations=[1,2,3,4,5], slotLength=9 — par (3,4): 4+5=9
        let expected = "[3, 4]"
        inputs = ["5", "1 2 3 4 5", "9"]
        validate(expected: expected)
    }

    func test_06() {
        // taskDurations=[3,3], slotLength=6 — par (0,1): 3+3=6 (valores iguais, indices diferentes)
        let expected = "[0, 1]"
        inputs = ["2", "3 3", "6"]
        validate(expected: expected)
    }

    func test_07() {
        // taskDurations=[1,2,3,4,5], slotLength=3 — par (0,1): 1+2=3
        let expected = "[0, 1]"
        inputs = ["5", "1 2 3 4 5", "3"]
        validate(expected: expected)
    }

    func test_08() {
        // taskDurations=[1,2,3,4,5], slotLength=10 — nenhum par valido (max=4+5=9)
        let expected = "[-1, -1]"
        inputs = ["5", "1 2 3 4 5", "10"]
        validate(expected: expected)
    }
}
