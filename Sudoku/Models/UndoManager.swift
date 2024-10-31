import SwiftUI

enum EditActionType {
    case none
    case add(digit: Int)
    case remove(digit: Int)
    case clearAll
}

struct UndoAction {
    let coordinate: Coordinate
    let previousValue: Int?
    let previousEditValues: Set<Int>
    let wasEditing: Bool
    let editActionType: EditActionType
}

@Observable final class UndoManager {
    private(set) var actions: [UndoAction] = []
    
    var canUndo: Bool {
        !actions.isEmpty
    }
    
    func addAction(_ action: UndoAction) {
        actions.append(action)
    }
    
    func undo() -> UndoAction? {
        guard canUndo else { return nil }
        return actions.removeLast()
    }
    
    func clear() {
        actions.removeAll()
    }
} 