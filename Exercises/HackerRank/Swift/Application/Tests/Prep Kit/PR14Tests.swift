import XCTest

final class PR14Tests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = ExPR14()

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
        // timestamps=[1,2,3,8,10], K=3 — mantem [1,8], length=2
        let expected = "2"
        inputs = ["5", "3", "1 2 3 8 10"]
        validate(expected: expected)
    }

    func test_02() {
        // timestamps=[], K=10 — lista vazia
        let expected = "0"
        inputs = ["0", "10"]
        validate(expected: expected)
    }

    func test_03() {
        // timestamps=[0], K=5 — unico elemento, sempre mantido
        let expected = "1"
        inputs = ["1", "5", "0"]
        validate(expected: expected)
    }

    /* Additional tests */
    func test_04() {
        // timestamps=[1,2,3,4,5], K=0 — K=0, todos sao mantidos (diff >= 0 sempre)
        let expected = "5"
        inputs = ["5", "0", "1 2 3 4 5"]
        validate(expected: expected)
    }

    func test_05() {
        // timestamps=[1,2,3,4,5], K=10 — so o primeiro eh mantido
        let expected = "1"
        inputs = ["5", "10", "1 2 3 4 5"]
        validate(expected: expected)
    }

    func test_06() {
        // timestamps=[1,5,10,15], K=4 — mantem [1,5,10,15], length=4
        let expected = "4"
        inputs = ["4", "4", "1 5 10 15"]
        validate(expected: expected)
    }

    func test_07() {
        // timestamps=[1,1,1,1], K=1 — todos iguais, diff=0 < 1, so o primeiro eh mantido
        let expected = "1"
        inputs = ["4", "1", "1 1 1 1"]
        validate(expected: expected)
    }

    func test_08() {
        // timestamps=[0,5,10,11,20], K=5 — mantem [0,5,10,20], length=4
        let expected = "4"
        inputs = ["5", "5", "0 5 10 11 20"]
        validate(expected: expected)
    }

    func test_09() {
        // timestamps=[1,3,5,7], K=3 — mantem [1,5] (5-1=4>=3, 7-5=2<3), length=2
        // adjacentes diferem 2 mas o keeped anterior importa — testa se compara com o ultimo mantido
        let expected = "2"
        inputs = ["4", "3", "1 3 5 7"]
        validate(expected: expected)
    }

    func test_10() {
        // timestamps=[1,2,4,7], K=3 — mantem [1,4,7] (4-1=3>=3, 7-4=3>=3), length=3
        // elemento intermediario (2) pulado, proximo valido (4) muda o ponto de referencia
        let expected = "3"
        inputs = ["4", "3", "1 2 4 7"]
        validate(expected: expected)
    }

    func test_11() {
        // timestamps=[1,2,3,4,7], K=3 — mantem [1,4,7] (4-1=3>=3, 7-4=3>=3), length=3
        // varios elementos descartados antes de encontrar o proximo valido
        let expected = "3"
        inputs = ["5", "3", "1 2 3 4 7"]
        validate(expected: expected)
    }
}
