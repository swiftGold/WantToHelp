//
//  JSONService.swift
//  Block1
//
//  Created by Сергей Золотухин on 30.05.2023.
//

import Foundation

protocol JSONServiceProtocol {
  func fetchCategoriesFromJSON(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
  func fetchFullEventDescriptionFromJSON(completion: @escaping (Result<[FullEventDescriptionModel], Error>) -> Void)
}

final class JSONService {
  private let decoder = JSONDecoder()
  
  private let jsonDecoderManager: JSONDecoderManagerProtocol
  
  init(jsonDecoderManager: JSONDecoderManagerProtocol) {
    self.jsonDecoderManager = jsonDecoderManager
  }
  
  enum FileType: String {
    case json
  }
}

extension JSONService: JSONServiceProtocol {
  func fetchCategoriesFromJSON(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
    read(filename: "Categories", fileType: FileType.json, completion: completion)
  }
  
  func fetchFullEventDescriptionFromJSON(completion: @escaping (Result<[FullEventDescriptionModel], Error>) -> Void) {
    read(filename: "Events", fileType: FileType.json, completion: completion)
  }
}

private extension JSONService {
  func encode(with model: [CategoryModel]) -> String {
    let jsonEncoder = JSONEncoder()
    guard let jsonData = try? jsonEncoder.encode(model) else { fatalError() }
    guard let json = String(data: jsonData, encoding: String.Encoding.utf8) else { fatalError() }
    return json
  }
  
  func read<T: Decodable>(filename: String, fileType: FileType, completion: @escaping (Result<T, Error>) -> Void) {
    guard let path = Bundle.main.path(forResource: filename, ofType: fileType.rawValue) else {
      completion(.failure(CustomError.jsonFilePathError))
      return
    }
    let url = URL(fileURLWithPath: path)
    do {
      let result = try Data(contentsOf: url)
      jsonDecoderManager.decode(result, completion: completion)
    } catch {
      completion(.failure(CustomError.fetchJsonFromFileError))
    }
  }
}
