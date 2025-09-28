//
//  HintButton.swift
//  Sudoku
//
//  Created by Ray Kim on 12/22/23.
//  Copyright © 2023 Self. All rights reserved.
//

import SwiftUI

struct HintButton: View {
    
    enum LoadingState: Equatable {
        case idle, loading, loaded(message: String), error(_ error: API.APIError?)
        
        var rawValue: String {
            switch self {
                case .idle: return ""
                case .loading: return "Generating hint..."
                case .loaded(message: let message): return message
            case .error(let errorType):
                if case .quotaExceeded = errorType {
                    return AlertItem.hintErrorQuota.message
                }
                return AlertItem.hintError.message
            }
        }
    }

    /// Note: used only for visionOS
    @Binding var alertItem: AlertItem?
    /// Note: used only for visionOS
    @Binding var alertIsPresented: Bool
    
    /// Note: used for iOS and iPadOS
    @State private var showingHintSheet = false
    /// Note: used for iOS and iPadOS
    @State private var hintState: LoadingState = .idle
    
    private static var hintCache: [String: Hint] = [:]
    static func clearCache() {
        hintCache.removeAll()
    }
    
    let grid: [CoordinateValue]
    let difficulty: Difficulty.Level
    
    private var placeholderText: String {
        let text =
        """
            placeholder text placeholder text placeholder text placeholder text
            placeholder text placeholder text placeholder text placeholder text
            placeholder text placeholder text placeholder text placeholder text
            placeholder text placeholder text placeholder text placeholder text
            placeholder text placeholder text placeholder text placeholder text
        """
        
        return text
    }
    
    private var textView: some View {
        Text(hintState.rawValue)
            .font(.system(.body, design: .rounded))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    private var placeholderView: some View {
        Text(placeholderText)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .redacted(reason: .placeholder)
            .shimmer()
    }
    
    var body: some View {
        Button("", systemImage: "lightbulb.max") {
            Task {
                await getHint()
            }
        }
        .tint(.primary)
        .symbolEffect(.pulse, value: hintState == .loading)
        .disabled(hintState == .loading)
        .sheet(isPresented: $showingHintSheet) {
            Group {
                if hintState == .loading {
                    placeholderView
                } else {
                    textView
                }
            }
            .padding(16)
            .transition(.opacity)
            .presentationDetents([.medium, .height(170)])
            .presentationDragIndicator(.visible)
            .animation(.easeInOut, value: hintState)
        }
    }
    
    private func updateOnSuccess(_ hint: Hint) {
        hintState = .loaded(message: hint.description)

        if isVision {
            alertItem = .hintSuccess(hint: hint.description)
            alertIsPresented = true
        }
    }
    
    private func updateOnError(_ error: API.APIError?) {
        hintState = .error(error)

        if isVision {
            alertItem = .hintError
            alertIsPresented = true
        }
    }
    
    private func updateWith(cachedHint: Hint) {
        var hintDescription = cachedHint.description

        switch cachedHint.hintType {
        case .nakedSingle:
            if let value = cachedHint.coordinate?.v {
                hintDescription = "Somewhere on the board, there is a naked single \(value). Can you find it?"
            }
        case .hiddenSingle:
            if let value = cachedHint.coordinate?.v {
                hintDescription = "Somewhere on the board, there is a hidden single \(value). Can you find it?"
            }
        default:
            break
        }

        let hint = Hint(coordinate: cachedHint.coordinate, hintType: cachedHint.hintType, overrideDescription: hintDescription)
        updateOnSuccess(hint)
    }

    private func getHint() async {
        do {
            showingHintSheet = !isVision
            hintState = .loading

            let cacheKey = grid.map { coordinate in String(coordinate.v) }.joined()
            
            if let cachedHint = Self.hintCache[cacheKey] {
                updateWith(cachedHint: cachedHint)
            } else if let hint = try await API.getHint(grid: grid, difficulty: difficulty) {
                Self.hintCache[cacheKey] = hint
                updateOnSuccess(hint)
            } else {
                updateOnError(nil)
            }
        } catch {
            updateOnError(error as? API.APIError)
        }
    }
}
