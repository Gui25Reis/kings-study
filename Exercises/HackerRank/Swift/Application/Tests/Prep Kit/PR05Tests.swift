import XCTest

final class PR05Tests: XCTestCase {

    var inputs: [String]!
    lazy var ex = ExPR05()

    /* Ciclo de Vida */
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
        // Prepare
        let provider = MockInputProvider(inputs: inputs)

        // Action
        let result = ex.solution(input: provider)

        // Validation
        XCTAssertEqual(expected, "\(result)")
    }


    /* Testes */
    func test_01() {
        // Prepare
        // nums=[1,2,3,4,5], target=3
        let expected = "2"
        inputs = ["5", "1", "2", "3", "4", "5", "3"]

        // Action
        validate(expected: expected)
    }

    func test_02() {
        // Prepare
        // nums=[2,4,6,8,10,12,14,16], target=16
        let expected = "7"
        inputs = ["8", "2", "4", "6", "8", "10", "12", "14", "16", "16"]

        // Action
        validate(expected: expected)
    }

    func test_03() {
        // Prepare - sample 0: array vazio
        // nums=[], target=5
        let expected = "-1"
        inputs = ["0", "5"]

        // Action
        validate(expected: expected)
    }

    func test_04() {
        // Prepare - sample 1: unico elemento encontrado
        // nums=[10], target=10
        let expected = "0"
        inputs = ["1", "10", "10"]

        // Action
        validate(expected: expected)
    }

    /* Additional tests */
    func test_05() {
        // Prepare - target nao existe no array
        // nums=[1,2,3,4,5], target=6
        let expected = "-1"
        inputs = ["5", "1", "2", "3", "4", "5", "6"]

        // Action
        validate(expected: expected)
    }

    func test_06() {
        // Prepare - target eh o primeiro elemento
        // nums=[1,2,3,4,5], target=1
        let expected = "0"
        inputs = ["5", "1", "2", "3", "4", "5", "1"]

        // Action
        validate(expected: expected)
    }

    func test_07() {
        // Prepare - target eh o ultimo elemento
        // nums=[1,2,3,4,5], target=5
        let expected = "4"
        inputs = ["5", "1", "2", "3", "4", "5", "5"]

        // Action
        validate(expected: expected)
    }

    func test_08() {
        // Prepare - target menor que todos os elementos
        // nums=[5,10,15,20], target=1
        let expected = "-1"
        inputs = ["4", "5", "10", "15", "20", "1"]

        // Action
        validate(expected: expected)
    }

    func test_09() {
        // Prepare - negativos no array
        // nums=[-5,-3,-1,2,4], target=-3
        let expected = "1"
        inputs = ["5", "-5", "-3", "-1", "2", "4", "-3"]

        // Action
        validate(expected: expected)
    }
    
    func test_10() {
        let expected = "-1"
        inputs = ["0", "5"]

        // Action
        validate(expected: expected)
    }
}
