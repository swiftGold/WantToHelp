//
//  AlamofireNetworkManager.swift
//  Block1
//
//  Created by Сергей Золотухин on 15.06.2023.
//

import Alamofire

final class AlamofireNetworkManager {
  private let jsonService: JSONDecoderManagerProtocol
  
  init(jsonService: JSONDecoderManagerProtocol) {
    self.jsonService = jsonService
  }
}

extension AlamofireNetworkManager: Networkable {
  func request<T>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
    
    guard let url = URL(string: urlString) else {
      completion(.failure(CustomError.urlError))
      return
    }
    
    AF.request(url)
      .response { dataResponse in
      if let error = dataResponse.error {
        completion(.failure(error))
        return
      }
      guard let statusCode = dataResponse.response?.statusCode else {
        completion(.failure(CustomError.httpUrlResponseError))
        return
      }
      switch statusCode {
      case 200...299:
        guard let data = dataResponse.data else {
          completion(.failure(CustomError.dataError))
          return
        }
        self.jsonService.decode(data, completion: completion)
      default:
        completion(.failure(CustomError.failureRequest(statusCode: statusCode)))
        break
      }
    }
  }
}
