/*
 Solve Diagonal Sudoku with 3x3 Blocks
 Given a 9x9 grid with empty cells marked as 0, fill the grid so that each row, column, 3x3 block, and both main diagonals contain numbers 1 to 9 exactly once.

 Examples
 Example 1

 Input:

 grid = [[5, 3, 4, 6, 7, 8, 9, 1, 2], [6, 7, 2, 1, 9, 5, 3, 4, 8], [1, 9, 8, 3, 4, 2, 5, 6, 7], [8, 5, 9, 7, 6, 1, 4, 2, 3], [4, 2, 6, 8, 5, 3, 7, 9, 1], [7, 1, 3, 9, 2, 4, 8, 5, 6], [9, 6, 1, 5, 3, 7, 2, 8, 4], [2, 8, 7, 4, 1, 9, 6, 3, 5], [3, 4, 5, 2, 8, 6, 1, 7, 0]]
 Output:

 [[5, 3, 4, 6, 7, 8, 9, 1, 2], [6, 7, 2, 1, 9, 5, 3, 4, 8], [1, 9, 8, 3, 4, 2, 5, 6, 7], [8, 5, 9, 7, 6, 1, 4, 2, 3], [4, 2, 6, 8, 5, 3, 7, 9, 1], [7, 1, 3, 9, 2, 4, 8, 5, 6], [9, 6, 1, 5, 3, 7, 2, 8, 4], [2, 8, 7, 4, 1, 9, 6, 3, 5], [3, 4, 5, 2, 8, 6, 1, 7, 9]]
 Explanation:

 In this near‐complete grid only one cell is empty at position (8,8).
 We check row 8 already contains {3,4,5,2,8,6,1,7}, so the missing number is 9.
 We also verify that placing 9 at (8,8) does not violate the row, column, 3×3 block, or either main diagonal constraints. Hence the completed grid is as shown.
 Example 2

 Input:

 grid = [[0, 0, 0, 6, 0, 0, 0, 0, 0], [0, 0, 2, 0, 0, 0, 0, 0, 8], [0, 0, 0, 0, 4, 0, 0, 0, 0], [0, 5, 0, 0, 0, 0, 0, 1, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 4, 0, 0, 0, 0, 0, 3, 0], [0, 0, 0, 0, 2, 0, 0, 0, 0], [6, 0, 0, 0, 0, 0, 3, 0, 0], [0, 0, 0, 0, 0, 7, 0, 0, 0]]
 Output:

 A valid completed 9×9 diagonal Sudoku grid that fills every 0 with 1–9 so that each row, column, 3×3 block, and both main diagonals contain all numbers 1–9 exactly once. (Any one correct solution is acceptable.)
 Explanation:

 This example shows a more challenging partial grid with multiple empty cells.
 A backtracking algorithm systematically tries numbers 1–9 in each empty spot, checks all constraints (row, column, 3×3 block, and both diagonals), and recurses.
 When a conflict arises it backtracks.
 The final output is a fully filled grid satisfying every constraint.
 Input Format

 The first line contains a single integer, grid_rows, representing the number of rows in the grid.
 The second line contains a single integer, grid_columns, representing the number of columns in the grid.
 The next grid_rows lines describe the grid's contents. Each of these lines contains grid_columns space-separated integers.
 3
 4
 8 1 6 0
 3 5 7 2
 4 9 2 1
 Explanation:

 grid_rows = 3
 grid_columns = 4
 grid = [[8, 1, 6, 0], [3, 5, 7, 2], [4, 9, 2, 1]]
 Constraints

 The input grid is a 9x9 matrix.
 Each cell contains an integer between 0 and 9, where 0 represents an empty cell.
 The given grid represents a valid, partially filled "Diagonal Sudoku" board, meaning:
 Each number from 1 to 9 appears at most once in each row.
 Each number from 1 to 9 appears at most once in each column.
 Each number from 1 to 9 appears at most once in each of the nine 3x3 sub-grids.
 Each number from 1 to 9 appears at most once on the main diagonal (top-left to bottom-right).
 Each number from 1 to 9 appears at most once on the anti-diagonal (top-right to bottom-left).
 Output Format

 Your function should return completed 9x9 grid.
 Sample Input 0

 9
 9
 5 3 4 6 7 8 9 1 2
 6 7 2 1 9 5 3 4 8
 1 9 8 3 4 2 5 6 7
 8 5 9 7 6 1 4 2 3
 4 2 6 8 5 3 7 9 1
 7 1 3 9 2 4 8 5 6
 9 6 1 5 3 7 2 8 4
 2 8 7 4 1 9 6 3 5
 3 4 5 2 8 6 1 7 9
 Sample Output 0

 5 3 4 6 7 8 9 1 2
 6 7 2 1 9 5 3 4 8
 1 9 8 3 4 2 5 6 7
 8 5 9 7 6 1 4 2 3
 4 2 6 8 5 3 7 9 1
 7 1 3 9 2 4 8 5 6
 9 6 1 5 3 7 2 8 4
 2 8 7 4 1 9 6 3 5
 3 4 5 2 8 6 1 7 9
 Sample Input 1

 9
 9
 5 3 4 6 7 8 9 1 2
 6 7 2 1 9 5 3 4 8
 1 9 8 3 4 2 5 6 7
 8 5 9 7 6 1 4 2 3
 4 2 6 8 5 3 7 9 1
 7 1 3 9 2 4 8 5 6
 9 6 1 5 3 7 2 8 4
 2 8 7 4 1 9 6 3 5
 3 4 5 2 8 6 1 7 0
 Sample Output 1

 5 3 4 6 7 8 9 1 2
 6 7 2 1 9 5 3 4 8
 1 9 8 3 4 2 5 6 7
 8 5 9 7 6 1 4 2 3
 4 2 6 8 5 3 7 9 1
 7 1 3 9 2 4 8 5 6
 9 6 1 5 3 7 2 8 4
 2 8 7 4 1 9 6 3 5
 3 4 5 2 8 6 1 7 9
 
 link: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/solve-diagonal-sudoku-3x3-blocks
 */

struct ExPR51 {
    func solution(input: InputProvider = DefaultInputProvider()) -> [[Int]] {
        guard let rowsInput = input.readLine(), let rows = Int(rowsInput)
        else { return [] }

        guard let _ = input.readLine() else { return [] } // columns (sempre 9)

        var grid = [[Int]]()
        for _ in 0..<rows {
            guard let line = input.readLine() else { continue }
            let row = line.components(separatedBy: " ").compactMap { Int($0) }
            grid.append(row)
        }

        return completeDiagonalSudokuGrid(grid: grid)
    }
}

// MARK: - Solution
fileprivate typealias Cell = (row: Int, col: Int)

fileprivate struct Mapper {
    var empty = [Cell]()
    var emptyCol = Array(repeating: 0, count: 9)
    var emptyRow = Array(repeating: 0, count: 9)
    var emptyQuad = Array(repeating: 0, count: 9)
    var emptyDPrinc = 0
    var emptyDSec = 0
    
    var rowSum = Array(repeating: 0, count: 9)
    var colSum = Array(repeating: 0, count: 9)
    var quadSum = Array(repeating: 0, count: 9)
    var diagPrinc = 0
    var diagSec = 0
}

fileprivate func isPrincipalDiagnonal(cell: Cell) -> Bool {
    cell.row == cell.col
}

fileprivate func isSecondaryDiagnonal(cell: Cell) -> Bool {
    cell.row + cell.col == 8
}

fileprivate func map(grid: [[Int]]) -> Mapper {
    var mapper = Mapper()
    
    for row in 0..<9 {
        var sum = 0
        defer { mapper.rowSum[row] = sum } // Save sum row
        
        let quadY = switch row {
        case 0...2: 0
        case 3...5: 3
        default: 6
        }
        
        for col in 0..<9 {
            let cellValue = grid[row][col]
            let cell = Cell(row, col)
            
            let quad = switch col {
            case 0...2: quadY+0
            case 3...5: quadY+1
            default: quadY+2
            }
            
            // Save zero position
            let isEmptyCell = cellValue == 0
            if isEmptyCell {
                mapper.empty.append(cell)
                mapper.emptyCol[col] += 1
                mapper.emptyRow[row] += 1
                mapper.emptyQuad[quad] += 1
            }
            
            // Save sum col
            sum += cellValue
            mapper.colSum[col] += cellValue
            
            // Save sum quad
            mapper.quadSum[quad] += cellValue
            
            // Diagnonals
            if isPrincipalDiagnonal(cell: cell) {
                mapper.diagPrinc += cellValue
                mapper.emptyDPrinc += isEmptyCell ? 1 : 0
            }
            
            if isSecondaryDiagnonal(cell: cell) {
                mapper.diagSec += cellValue
                mapper.emptyDSec += isEmptyCell ? 1 : 0
            }
        }
    }
    
    return mapper
}

fileprivate func findQuad(for cell: Cell) -> Int {
    let quadY = switch cell.row {
    case 0...2: 0
    case 3...5: 3
    default: 6
    }
        
    return switch cell.col {
    case 0...2: quadY+0
    case 3...5: quadY+1
    default: quadY+2
    }
}

fileprivate func validateCell(for cell: Cell, mapper: inout Mapper) -> Int {
    let total9x9sum = 45
    lazy var quad = findQuad(for: cell)
    
    func addMissingCell(value: Int) -> Int {
        mapper.rowSum[cell.row] += value
        mapper.emptyRow[cell.row] -= 1
        
        mapper.colSum[cell.col] += value
        mapper.emptyCol[cell.col] -= 1
        
        mapper.quadSum[quad] += value
        mapper.emptyQuad[quad] -= 1
        
        if isPrincipalDiagnonal(cell: cell) {
            mapper.diagPrinc += value
            mapper.emptyDPrinc -= 1
        }
        
        if isSecondaryDiagnonal(cell: cell) {
            mapper.diagSec += value
            mapper.emptyDSec -= 1
        }
        
        return value
    }
    
    // Row
    if mapper.emptyRow[cell.row] == 1 {
        let missingCell = total9x9sum - mapper.rowSum[cell.row]
        return addMissingCell(value: missingCell)
    }
    
    // Col
    if mapper.emptyCol[cell.col] == 1 {
        let missingCell = total9x9sum - mapper.colSum[cell.col]
        return addMissingCell(value: missingCell)
    }
    
    // Quad
    if mapper.emptyQuad[quad] == 1 {
        let missingCell = total9x9sum - mapper.quadSum[quad]
        return addMissingCell(value: missingCell)
    }
    
    // Princ
    if isPrincipalDiagnonal(cell: cell) && mapper.emptyDPrinc == 1 {
        let missingCell = total9x9sum - mapper.diagPrinc
        return addMissingCell(value: missingCell)
    }
    
    // Sec
    if isSecondaryDiagnonal(cell: cell) && mapper.emptyDSec == 1 {
        let missingCell = total9x9sum - mapper.diagSec
        return addMissingCell(value: missingCell)
    }
    
    return -1
}

fileprivate func completeDiagonalSudokuGrid(grid: [[Int]]) -> [[Int]] {
    var mapper = map(grid: grid)

    // No zero received
    if mapper.empty.isEmpty {
        return grid
    }

    var grid = grid

    while !mapper.empty.isEmpty {
        let cell = mapper.empty[0]

        let missingCell = validateCell(for: cell, mapper: &mapper)

        if missingCell == -1 {
            // Not possible to check, putting in the end
            let first = mapper.empty.removeFirst()
            mapper.empty.append(first)
            continue
        }

        grid[cell.row][cell.col] = missingCell
        mapper.empty.removeFirst()
    }

    return grid
}


// MARK: - AI Solution
fileprivate func aiSolution(grid: [[Int]]) -> [[Int]] {
    var grid = grid

    func isValid(_ num: Int, row: Int, col: Int) -> Bool {
        // Row
        if grid[row].contains(num) { return false }

        // Col
        if grid.map({ $0[col] }).contains(num) { return false }

        // Quad
        let startRow = (row / 3) * 3
        let startCol = (col / 3) * 3
        for r in startRow..<startRow+3 {
            for c in startCol..<startCol+3 {
                if grid[r][c] == num { return false }
            }
        }

        // Principal diagonal
        if row == col {
            for i in 0..<9 {
                if grid[i][i] == num { return false }
            }
        }

        // Secondary diagonal
        if row + col == 8 {
            for i in 0..<9 {
                if grid[i][8-i] == num { return false }
            }
        }

        return true
    }
    
    @discardableResult
    func solve() -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                guard grid[row][col] == 0 else { continue }

                for num in 1...9 {
                    if isValid(num, row: row, col: col) {
                        grid[row][col] = num
                        if solve() { return true }
                        grid[row][col] = 0 // backtrack
                    }
                }

                return false // nenhum número funcionou, volta
            }
        }
        return true // sem zeros restantes
    }

    solve()
    return grid
}
