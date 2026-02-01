//
//  Logger.swift
//  Better Wheel
//
//  Created by MasoodDalman on 1.02.2026.
//

import Foundation

/// A simple logging utility for Better Wheel
class Logger {
    
    /// Log message types with associated icons
    enum LogType {
        case info
        case success
        case warning
        case error
        case debug
        case network
        case accessibility
        case scroll
        
        /// Icon representation for each log type
        var icon: String {
            switch self {
            case .info:
                return "ℹ️"
            case .success:
                return "✅"
            case .warning:
                return "⚠️"
            case .error:
                return "❌"
            case .debug:
                return "🔍"
            case .network:
                return "🌐"
            case .accessibility:
                return "🔐"
            case .scroll:
                return "🖱️"
            }
        }
        
        /// Tag for categorizing logs
        var tag: String {
            switch self {
            case .info:
                return "INFO"
            case .success:
                return "SUCCESS"
            case .warning:
                return "WARNING"
            case .error:
                return "ERROR"
            case .debug:
                return "DEBUG"
            case .network:
                return "NETWORK"
            case .accessibility:
                return "ACCESS"
            case .scroll:
                return "SCROLL"
            }
        }
    }
    
    /// Log a message with the specified type
    /// - Parameters:
    ///   - message: The message to log
    ///   - type: The type of log message
    static func log(_ message: String, type: LogType = .info) {
        let timestamp = DateFormatter.logTimestamp.string(from: Date())
        print("\(type.icon) [\(timestamp)] [\(type.tag)] \(message)")
    }
}

// MARK: - DateFormatter Extension
private extension DateFormatter {
    static let logTimestamp: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        return formatter
    }()
}
