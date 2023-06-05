//
//  JSONService.swift
//  Block1
//
//  Created by Сергей Золотухин on 30.05.2023.
//

import Foundation
import SwiftyJSON

protocol JSONServiceProtocol {
  func fetchCategoriesFromJSON(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
  func fetchFullEventDescriptionFromJSON(completion: @escaping (Result<[FullEventDescriptionModel], Error>) -> Void)
}

final class JSONService {
  private let decoder = JSONDecoder()
}

extension JSONService: JSONServiceProtocol {
  func fetchCategoriesFromJSON(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
    guard let jsonFromFile = getJsonFromFile(jsonFileName: "Categories") else {
      let myError = NSError(domain: "Cant fetch JSON from file", code: -444)
      completion(.failure(myError))
      return
    }
    let json = JSON(jsonFromFile)
    let jsonString = encodeFromJson(with: json)
    decode(with: jsonString, completion: completion)
  }
  
  func fetchFullEventDescriptionFromJSON(completion: @escaping (Result<[FullEventDescriptionModel], Error>) -> Void) {
    guard let jsonFromFile = getJsonFromFile(jsonFileName: "Events") else {
      let myError = NSError(domain: "Cant fetch JSON from file", code: -444)
      completion(.failure(myError))
      return
    }
    let json = JSON(jsonFromFile)
    let jsonString = encodeFromJson(with: json)
    decode(with: jsonString, completion: completion)
  }
  
  func encode(with model: [CategoryModel]) -> String {
    let jsonEncoder = JSONEncoder()
    guard let jsonData = try? jsonEncoder.encode(model) else { fatalError() }
    guard let json = String(data: jsonData, encoding: String.Encoding.utf8) else { fatalError() }
    return json
  }
}

private extension JSONService {
  func decode<T: Decodable>(with jsonString: String, completion: @escaping (Result<T, Error>) -> Void) {
    guard let jsonData = jsonString.data(using: .utf8) else { return }
    do {
      let tasks = try decoder.decode(T.self, from: jsonData)
      return completion(.success(tasks))
    } catch {
      let myError = NSError(domain: "cant decode from data", code: -333, userInfo: nil)
      return completion(.failure(myError))
    }
  }
  
  func getJsonFromFile(jsonFileName: String) -> JSON? {
    guard let path = Bundle.main.path(forResource: jsonFileName, ofType: "json") else { fatalError() }
    let url = URL(fileURLWithPath: path)
    
    do {
      let data = try Data(contentsOf: url)
      let json = try JSON(data: data)
      return json
    } catch {
      print(error.localizedDescription)
    }
    return nil
  }
  
  func encodeFromJson(with model: JSON) -> String {
    let jsonEncoder = JSONEncoder()
    guard let jsonData = try? jsonEncoder.encode(model) else { fatalError() }
    guard let json = String(data: jsonData, encoding: String.Encoding.utf8) else { fatalError() }
    return json
  }
}
