import XCTest

final class PR16Tests: XCTestCase {

    var inputs: [String]!
    lazy var ex = ExPR16()

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
        // s="listen", t="silent" — anagrama valido
        let expected = "1"
        inputs = ["listen", "silent"]
        validate(expected: expected)
    }

    func test_02() {
        // s="hello", t="bellow" — tamanhos diferentes
        let expected = "0"
        inputs = ["hello", "bellow"]
        validate(expected: expected)
    }

    func test_03() {
        // s="a", t="a"
        let expected = "1"
        inputs = ["a", "a"]
        validate(expected: expected)
    }

    func test_04() {
        // s="ab", t="ba"
        let expected = "1"
        inputs = ["ab", "ba"]
        validate(expected: expected)
    }

    /* Additional tests */
    func test_05() {
        // s="", t="" — ambas vazias
        let expected = "1"
        inputs = ["", ""]
        validate(expected: expected)
    }

    func test_06() {
        // s="a", t="" — tamanhos diferentes
        let expected = "0"
        inputs = ["a", ""]
        validate(expected: expected)
    }

    func test_07() {
        // s="aab", t="aba" — mesmos caracteres, frequencias iguais
        let expected = "1"
        inputs = ["aab", "aba"]
        validate(expected: expected)
    }

    func test_08() {
        // s="aab", t="aaa" — mesmas letras mas frequencias diferentes
        let expected = "0"
        inputs = ["aab", "aaa"]
        validate(expected: expected)
    }

    func test_09() {
        // s="rat", t="car" — mesmos tamanhos, letras diferentes
        let expected = "0"
        inputs = ["rat", "car"]
        validate(expected: expected)
    }
}
