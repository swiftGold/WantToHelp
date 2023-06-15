protocol APIServiceProtocol {
  func fetchCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void)
  func fetchEvents(completion: @escaping (Result<[FullEventDescriptionModel], Error>) -> Void)
}

final class APIService {
  enum url {
    static let categoriesUrl = "https://wanttohelp-cbaa8-default-rtdb.europe-west1.firebasedatabase.app/categories.json"
    static let eventsUrl = "https://wanttohelp-cbaa8-default-rtdb.europe-west1.firebasedatabase.app/events.json"
  }
  
  private let networkManager: Networkable
  private let alamofireNetworkManager: Networkable
  
  init(
    networkManager: Networkable,
    alamofireNetworkManager: Networkable
  ) {
    self.networkManager = networkManager
    self.alamofireNetworkManager = alamofireNetworkManager
  }
}

extension APIService: APIServiceProtocol {
  func fetchCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
    let urlString = url.categoriesUrl
    alamofireNetworkManager.request(urlString: urlString, completion: completion)
  }
  
  func fetchEvents(completion: @escaping (Result<[FullEventDescriptionModel], Error>) -> Void) {
    let urlString = url.eventsUrl
    alamofireNetworkManager.request(urlString: urlString, completion: completion)
  }
}
