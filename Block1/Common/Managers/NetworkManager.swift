import Foundation

protocol Networkable {
  func request<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void)
}

public final class NetworkManager {
  private let jsonService: JSONDecoderManagerProtocol
  
  init(jsonService: JSONDecoderManagerProtocol) {
    self.jsonService = jsonService
  }
}

extension NetworkManager: Networkable {
  
  func request<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
    guard let url = URL(string: urlString) else {
      completion(.failure(CustomError.urlError))
      return
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    let session = URLSession.shared
    let task = session.dataTask(with: urlRequest) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      guard let httpURLresponse = response as? HTTPURLResponse else {
        completion(.failure(CustomError.httpUrlResponseError))
        return
      }
      let statusCode = httpURLresponse.statusCode
      switch statusCode {
      case 200...299:
        guard let data = data else {
          completion(.failure(CustomError.dataError))
          return
        }
        self.jsonService.decode(data, completion: completion)
      default:
        completion(.failure(CustomError.failureRequest(statusCode: statusCode)))
        break
      }
    }
    task.resume()
  }
}

enum CustomError: Error {
  case urlError
  case httpUrlResponseError
  case dataError
  case failureRequest(statusCode: Int)
  
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
    }
  }
}

enum NetworkError: Error {
  case url
}
