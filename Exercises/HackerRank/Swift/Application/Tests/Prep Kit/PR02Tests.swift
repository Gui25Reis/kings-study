import XCTest

final class PR02Tests: XCTestCase {

    var inputs: [String]!
    lazy var ex = ExPR02()

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
        // orderNumbers=[3,4,-1,1]
        let expected = "2"
        inputs = ["4", "3", "4", "-1", "1"]

        // Action
        validate(expected: expected)
    }

    func test_02() {
        // Prepare - array vazio, menor positivo é 1
        // orderNumbers=[]
        let expected = "1"
        inputs = ["0"]

        // Action
        validate(expected: expected)
    }

    func test_03() {
        // Prepare - sample 0: n=0
        // orderNumbers=[]
        let expected = "1"
        inputs = ["0"]

        // Action
        validate(expected: expected)
    }

    func test_04() {
        // Prepare - sample 1: único elemento é 1
        // orderNumbers=[1]
        let expected = "2"
        inputs = ["1", "1"]

        // Action
        validate(expected: expected)
    }


    /* MARK: - Additional tests */
    func test_05() {
        // Prepare - sequência completa de 1..n, faltando o próximo
        // orderNumbers=[1,2,3]
        let expected = "4"
        inputs = ["3", "1", "2", "3"]

        // Action
        validate(expected: expected)
    }

    func test_06() {
        // Prepare - só negativos, menor positivo é 1
        // orderNumbers=[-3,-2,-1]
        let expected = "1"
        inputs = ["3", "-3", "-2", "-1"]

        // Action
        validate(expected: expected)
    }

    func test_07() {
        // Prepare - duplicatas no array
        // orderNumbers=[1,1,2,2]
        let expected = "3"
        inputs = ["4", "1", "1", "2", "2"]

        // Action
        validate(expected: expected)
    }

    func test_08() {
        // Prepare - números grandes, mas falta o 1
        // orderNumbers=[100,200,300]
        let expected = "1"
        inputs = ["3", "100", "200", "300"]

        // Action
        validate(expected: expected)
    }

    func test_09() {
        // Prepare - mix de negativos, zeros e positivos desordenados
        // orderNumbers=[0,-1,2,1,5]
        let expected = "3"
        inputs = ["5", "0", "-1", "2", "1", "5"]

        // Action
        validate(expected: expected)
    }

    func test_10() {
        // Prepare - todos os elementos 1..n presentes, em pares invertidos
        // orderNumbers=[2,1,4,3,6,5]
        let expected = "7"
        inputs = ["6", "2", "1", "4", "3", "6", "5"]

        // Action
        validate(expected: expected)
    }

    func test_11() {
        // Prepare - todos os elementos 1..n presentes, ordem invertida com swap no final
        // orderNumbers=[4,3,2,1,6,5]
        let expected = "7"
        inputs = ["6", "4", "3", "2", "1", "6", "5"]

        // Action
        validate(expected: expected)
    }
}
