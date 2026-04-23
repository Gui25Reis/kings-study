import XCTest

final class PR07Tests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = ExPR07()

    /* Ciclo de Vida */
    override func setUp() {
        super.setUp()
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
        // meetings=[[1,2],[2,3],[3,4],[1,3]]
        let expected = "3"
        inputs = ["4", "2", "1 2", "2 3", "3 4", "1 3"]

        // Action
        validate(expected: expected)
    }

    func test_02() {
        // Prepare
        // meetings=[[0,5],[0,1],[1,2],[2,3],[3,5],[4,6]]
        let expected = "4"
        inputs = ["6", "2", "0 5", "0 1", "1 2", "2 3", "3 5", "4 6"]

        // Action
        validate(expected: expected)
    }

    func test_03() {
        // Prepare - sample 0: unico intervalo
        // meetings=[[5,10]]
        let expected = "1"
        inputs = ["1", "2", "5 10"]

        // Action
        validate(expected: expected)
    }

    func test_04() {
        // Prepare - sample 1: intervalos adjacentes
        // meetings=[[1,2],[2,3],[3,4]]
        let expected = "3"
        inputs = ["3", "2", "1 2", "2 3", "3 4"]

        // Action
        validate(expected: expected)
    }

    /* Additional tests */
    func test_05() {
        // Prepare - array vazio
        // meetings=[]
        let expected = "0"
        inputs = ["0", "2"]

        // Action
        validate(expected: expected)
    }

    func test_06() {
        // Prepare - todos os intervalos sobrepostos, so um pode ser escolhido
        // meetings=[[1,10],[2,9],[3,8]]
        let expected = "1"
        inputs = ["3", "2", "1 10", "2 9", "3 8"]

        // Action
        validate(expected: expected)
    }

    func test_07() {
        // Prepare - intervalos fora de ordem, resultado depende do sort por end time
        // meetings=[[6,8],[1,2],[3,5],[2,4]]
        let expected = "3"
        inputs = ["4", "2", "6 8", "1 2", "3 5", "2 4"]

        // Action
        validate(expected: expected)
    }

    func test_08() {
        // Prepare - intervalos com mesmo end time
        // meetings=[[1,3],[2,3],[3,5]]
        let expected = "2"
        inputs = ["3", "2", "1 3", "2 3", "3 5"]

        // Action
        validate(expected: expected)
    }
}
