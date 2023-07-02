//
//  WebViewViewController.swift
//  Block1
//
//  Created by Сергей Золотухин on 27.06.2023.
//

import UIKit
import WebKit

protocol WebViewViewControllerProtocol: UIViewController {
  func showAlert(with viewController: UIViewController)
}

final class WebViewViewController: UIViewController {
  // MARK: - UI
  private lazy var closeButton: UIButton = {
    let button = UIButton(type: .system)
    button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
    button.tintColor =  UIColor.specialTitleColor
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let webView = WKWebView()
  
  // MARK: - Variables
  var presenter: WebViewPresenterProtocol?
  
  // MARK: - life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.isNavigationBarHidden = true
    setupViewController()
    configWebView()
  }
  
  // MARK: - Objc methods
  @objc
  private func didTapCloseButton() {
    presenter?.didTapCloseButton()
  }
}

// MARK: - WebViewViewControllerProtocol impl
extension WebViewViewController: WebViewViewControllerProtocol {
  func showAlert(with viewController: UIViewController) {
    present(viewController, animated: true)
  }
}

// MARK: - WKNavigationDelegate
extension WebViewViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
    
    guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
      decisionHandler(.allow)
      return
    }
    
    let params = fragment
      .components(separatedBy: "&")
      .map { $0.components(separatedBy: "=")}
      .reduce([String: String]()) { res, param in
      var dict = res
      let key = param[0]
      let value = param[1]
      dict[key] = value
      return dict
    }
    
    if let accsessToken = params["access_token"] {
      UserDefaults.standard.set(accsessToken, forKey: "access_token")
    } else {
      let message = "error with recieve token"
      self.callErrorAlert(message: message)
    }
    
    if let expiresIn = params["expires_in"] {
      guard let doubleDate = Double(expiresIn) else { return }
      let date = Date().addingTimeInterval(doubleDate)
      UserDefaults.standard.set(date, forKey: "expires_in")
    }else {
      let message = "error with recieve expires time"
      self.callErrorAlert(message: message)
    }
    decisionHandler(.cancel)
    
    presenter?.didFetchToken()
  }
}

// MARK: - private methods
private extension WebViewViewController {
  func configWebView() {
    webView.translatesAutoresizingMaskIntoConstraints = false
    webView.allowsBackForwardNavigationGestures = true
    webView.navigationDelegate = self
    loadRequest()
  }
  
  func loadRequest() {
    var urlComponent = URLComponents()
    urlComponent.scheme = "https"
    urlComponent.host = "oauth.vk.com"
    urlComponent.path = "/authorize"
    
    urlComponent.queryItems = [
      URLQueryItem(name: "client_id", value: "51690466"),
      URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
      URLQueryItem(name: "display", value: "mobile"),
      URLQueryItem(name: "scope", value: "photos"),
      URLQueryItem(name: "response_type", value: "token")
    ]
    
    let req = URLRequest(url: urlComponent.url!)
    webView.load(req)
  }
  
  func setupViewController() {
    view.backgroundColor = .specialLightBlueBGColor
    addSubviews()
    setConstraints()
  }
  
  func addSubviews() {
    view.addSubview(closeButton)
    view.addSubview(webView)
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate([
      closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      
      webView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10),
      webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}
