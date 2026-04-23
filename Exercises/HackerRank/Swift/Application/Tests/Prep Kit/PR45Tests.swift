import XCTest

final class PR45Tests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = ExPR45()

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
        // nums=[2,-1,2,1,-2,3], k=3, M=2
        let expected = "2"
        inputs = ["6", "2", "-1", "2", "1", "-2", "3", "3", "2"]

        // Action
        validate(expected: expected)
    }

    func test_02() {
        // Prepare - array vazio
        // nums=[], k=3, M=2
        let expected = "0"
        inputs = ["0", "3", "2"]

        // Action
        validate(expected: expected)
    }

    func test_03() {
        // Prepare - nenhum elemento passa no filtro de M
        // nums=[5,6,7], k=3, M=4
        let expected = "0"
        inputs = ["3", "5", "6", "7", "3", "4"]

        // Action
        validate(expected: expected)
    }

    func test_04() {
        // Prepare - subarray de um único elemento igual a k e <= M
        // nums=[1,3,2], k=3, M=3
        let expected = "1"
        inputs = ["3", "1", "3", "2", "3", "3"]

        // Action
        validate(expected: expected)
    }

    func test_05() {
        // Prepare - negativos no array
        // nums=[1,2,3,-1,4,-2,2], k=4, M=3
        let expected = "1"
        inputs = ["7", "1", "2", "3", "-1", "4", "-2", "2", "4", "3"]

        // Action
        validate(expected: expected)
    }


    /* MARK: - Additional tests */
    func test_06() {
        // Prepare - elemento > M no meio invalida o subarray inteiro
        // nums=[1,5,2], k=3, M=3
        let expected = "0"
        inputs = ["3", "1", "5", "2", "3", "3"]

        // Action
        validate(expected: expected)
    }

    func test_07() {
        // Prepare - elemento > M intercalado, só um subarray válido após ele
        // nums=[2,5,1,2], k=3, M=3
        let expected = "1"
        inputs = ["4", "2", "5", "1", "2", "3", "3"]

        // Action
        validate(expected: expected)
    }

    func test_08() {
        // Prepare - múltiplos subarrays com mesma soma, todos elementos iguais a M
        // nums=[1,1,1,1], k=2, M=1
        let expected = "3"
        inputs = ["4", "1", "1", "1", "1", "2", "1"]

        // Action
        validate(expected: expected)
    }

    func test_09() {
        // Prepare - k negativo com negativos no array
        // nums=[-1,-2,1], k=-1, M=1
        let expected = "2"
        inputs = ["3", "-1", "-2", "1", "-1", "1"]

        // Action
        validate(expected: expected)
    }

    func test_10() {
        // Prepare - primeiro elemento == k, mas há subarray maior começando nele que também == k
        // nums=[3,-1,1], k=3, M=3
        let expected = "2"
        inputs = ["3", "3", "-1", "1", "3", "3"]

        // Action
        validate(expected: expected)
    }

    func test_11() {
        // Prepare - subarray encontrado em j, mas há outro começando no mesmo start em j' > j (negativos no meio)
        // nums=[1,2,-2,2], k=3, M=3
        let expected = "2"
        inputs = ["4", "1", "2", "-2", "2", "3", "3"]

        // Action
        validate(expected: expected)
    }

    func test_12() {
        // Prepare - primeiro elemento == k, mas subarrays maiores começando nele também somam k (negativos no meio)
        // nums=[3,0,-1,1], k=3, M=3
        // válidos: [3], [3,0], [3,0,-1,1]
        let expected = "3"
        inputs = ["4", "3", "0", "-1", "1", "3", "3"]

        // Action
        validate(expected: expected)
    }
}
