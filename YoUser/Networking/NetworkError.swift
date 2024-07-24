//
//  NetworkError.swift
//  YoUser
//
//  Created by Ruzanna on 24.07.24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
}
