//
//  WebViewController.swift
//  alifsTrello
//
//  Created by Jahongir Anvarov on 26.09.2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    private let urlString: String
    private let webView = WKWebView()
    
    init(with urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        setupConstraints()
        guard let url = URL(string: urlString) else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        webView.load(URLRequest(url: url))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        
    }
    
    // MARK: - Private methods
    
    @objc private func didTapDone() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupConstraints() {
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
}
