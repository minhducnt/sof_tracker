//
//  Created by TMA on 02/20/25.
//
import Foundation

enum AppError: Error, Identifiable {
    var id: String { localizedDescription }

    case apiError(String)
    case networkError(Error)
    case serverError(String)
    case decodingError(Error)
    case otherError(String)
    case genericError
    case unauthorizedAccess
    case failedToLoadToken
    case tokenStoringFailed


    var localizedDescription: String {
        switch self {
        case .apiError(let message):
            return message
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .serverError(let message):
            return "Server error - \(message)"
        case .decodingError(let error):
            return "Data decoding error: \(error.localizedDescription)"
        case .otherError(let message):
            return message
        case .genericError:
            return "Something went wrong! Please try again."
        case .unauthorizedAccess:
            return "Access denied."
        case .failedToLoadToken:
            return "Something went wrong! Please try again."
        case .tokenStoringFailed:
            return "Failed to store token."
        }
    }
}
