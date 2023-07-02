import Foundation

protocol JSONDecoderManagerProtocol {
  func decode<T: Decodable>(_ data: Data, completion: (Result<T, Error>) -> Void)
}

final class JSONDecoderManager {
  private let decoder = JSONDecoder()
  init() {}
}

extension JSONDecoderManager: JSONDecoderManagerProtocol {
  func decode<T: Decodable>(_ data: Data, completion: (Result<T, Error>) -> Void) {
    do {
      let result = try decoder.decode(T.self, from: data)
      return completion(.success(result))
    } catch {
      return completion(.failure(CustomError.decodeError))
    }
  }
}
