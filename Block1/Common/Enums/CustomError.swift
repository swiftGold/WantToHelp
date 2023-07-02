//
//  CustomError.swift
//  Block1
//
//  Created by Сергей Золотухин on 02.07.2023.
//

enum CustomError: Error {
  case urlError
  case httpUrlResponseError
  case dataError
  case failureRequest(statusCode: Int)
  case jsonFilePathError
  case fetchJsonFromFileError
  case decodeError
  
  var message: String {
    switch self {
    case .urlError:
      return "urlError description"
    case .httpUrlResponseError:
      return "httpUrlResponseError description"
    case .dataError:
      return "dataError description"
    case .failureRequest(statusCode: let statusCode):
      return "failureRequest description - statusCode - \(statusCode)"
    case .jsonFilePathError:
      return "wrong decode file path"
    case .fetchJsonFromFileError:
      return "can't fetch JSON from file"
    case .decodeError:
      return "can't decode JSON"
    }
  }
}
