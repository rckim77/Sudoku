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
    
    private static var hintCache: [String: String] = [:]
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
        Button("Hint", systemImage: "lightbulb.max") {
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
    
    private func getHint() async {
        func updateOnSuccess(_ hint: String) {
            hintState = .loaded(message: hint)

            if isVision {
                alertItem = .hintSuccess(hint: hint)
                alertIsPresented = true
            }
        }
        do {
            showingHintSheet = !isVision
            hintState = .loading
            
            let cacheKey = grid.map { coordinate in String(coordinate.v) }.joined()
            
            if let cachedHint = Self.hintCache[cacheKey] {
                updateOnSuccess(cachedHint)
                return
            }
            
            if let hint = try await API.getHint(grid: grid, difficulty: difficulty) {
                Self.hintCache[cacheKey] = hint
                updateOnSuccess(hint)
            } else {
                hintState = .error(nil)

                if isVision {
                    alertItem = .hintError
                    alertIsPresented = true
                }
            }
        } catch {
            hintState = .error(error as? API.APIError)

            if isVision {
                alertItem = .hintError
                alertIsPresented = true
            }
        }
    }
}
