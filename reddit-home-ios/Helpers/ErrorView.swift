//
//  ErrorView.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import UIKit

final class ErrorView: UIView {
    
    private let messageLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .systemRed
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let retryButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Retry"
        config.baseBackgroundColor = .systemBlue
        config.cornerStyle = .medium
        
        let btn = UIButton(configuration: config)
        return btn
    }()
    
    var onRetry: (() -> Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        addSubview(messageLabel)
        addSubview(retryButton)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        retryButton.addTarget(self, action: #selector(onRetryTap), for: .touchUpInside)
    }
    
    @objc private func onRetryTap() {
        onRetry?()
    }
    
    func setErrorMessage(_ message: String) {
        messageLabel.text = message
    }
}
