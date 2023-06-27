import Foundation

protocol JSONDecoderManagerProtocol {
  func decode<T: Decodable>(_ data: Data, completion: (Result<T, Error>) -> Void)
  func decode<T: Decodable>(_ data: Data) throws -> T
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
      return completion(.failure(error))
    }
  }
  
  func decode<T: Decodable>(_ data: Data) throws -> T {
    return try decoder.decode(T.self, from: data)
  }
}


//под обработку ошибок
//func decode<T: Decodable>(_ data: Data) -> Result<T, Error> {
//    do {
//        let result = try decoder.decode(T.self, from: data)
//        return .success(result)
//    } catch {
//        return .failure(error)
//    }
//}
