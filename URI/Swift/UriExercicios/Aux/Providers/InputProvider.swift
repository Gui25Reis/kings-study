//
//  Gui Reis  -  gui.sreis25@gmail.com - 23/02/24.
//


protocol InputProvider: AnyObject {
    var shouldConsidereNextLineForEachPrint: Bool { get set }
    
    func readLine() -> String?
    func print(_ data: String)
}


class DefaultInputProvider: InputProvider {
    var shouldConsidereNextLineForEachPrint = false
    
    func readLine() -> String? {
        return Swift.readLine()
    }
    
    func print(_ data: String) {
        Swift.print(data)
    }
}


class MockInputProvider: InputProvider {
    
    var shouldConsidereNextLineForEachPrint = false
    
    private let inputs: [String]
    private var index = 0
    
    var dataPrinted: String?

    init(inputs: [String]) {
        self.inputs = inputs
    }

    func readLine() -> String? {
        guard index < inputs.count else { return nil }
        defer { index += 1 }
        return inputs[index]
    }
    
    func print(_ data: String) {
        guard shouldConsidereNextLineForEachPrint else {
            dataPrinted = data
            return
        }
        
        if let _ = dataPrinted {
            dataPrinted? += "\n\(data)"
        } else {
            dataPrinted = data
        }
    }
}
